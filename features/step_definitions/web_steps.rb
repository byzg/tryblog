#coding: utf-8
PAGES={
    "Главная" => '/'
}

Пусть(/^я захожу на страницу "(.*?)"$/) do |page|
  visit PAGES[page]
end

Пусть(/^я вижу "(.*?)"$/) do |text|
  page.should have_text text
end

Пусть(/^я жду "(.*?)" секунд.*$/) do |seconds|
  sleep seconds.to_i
end

When /^я ввожу "([^"]*)" в поле "([^"]*)"$/ do |value, field|
  begin
    fill_in field, with: value
    field = page.find_field(field)
    begin
      id = field[:id] if field.present?
      page.execute_script("jQuery('##{id}').trigger('blur');") if id.present?
    rescue
      nil
    end
  rescue
    page.execute_script("jQuery('##{field}').val('#{value}');")
    page.execute_script("jQuery('##{field}').trigger('blur');")
  end
end

When /^я нажимаю кнопку "([^"]*)"$/ do |button_name|
  button_name = I18n.t(button_name[1..-1].to_sym) if button_name.first == ':'
  begin
    click_button button_name
  rescue
    if button_name.first == '#'
      page.execute_script("jQuery('input##{button_name}').click()")
    else
      page.execute_script(%|jQuery('input[value="#{button_name}"]').click()|)
    end
  end
end

Тогда(/^в диве с классом "(.*?)" должно быть "(.*?)"$/) do |css_class, text|
  page.should have_selector("div.#{css_class}", text: /#{text}/i)
end