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

Пусть(/^я жду (\d+) секунд.*$/) do |seconds|
  sleep seconds.to_i
end

When /^я ввожу "([^"]*)" в поле "([^"]*)"$/ do |value, field_id|
  fill_in field_id, with: value
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

Тогда(/^должен быть селектор "(.*?)"(?: c "(.*?)")?$/) do |selector, text|
  text ||= ""
  page.should have_selector(selector, text: /#{text}/i)
end


Пусть(/^я нажимаю на селектор "(.*?)"$/) do |selector|
  find(selector).click
end

