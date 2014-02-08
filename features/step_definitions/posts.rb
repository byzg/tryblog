#coding: utf-8
FORM = "#form_block form.new_post"
SAVE_LIST = '#save_list'
def post_block(id)
  ".challenge-instructions #post_block_#{id}"
end
def id_current_post
  find(FORM)['action'][/\d+$/]
end
Пусть(/^я создаю пост с темой "(.*?)" и текстом "(.*?)"$/) do |subject, content|
  within(FORM) do
    fill_in 'post_subject', with: subject
    fill_in 'post_content', with: content
  end
  find("#submit_current1_post").click
  step "я жду 1 секунду"
end

Пусть(/^создан(?:о)? (\d+) пост(?:а|ов)?$/) do |count|
  (1..count.to_i).each {|i| Post.create(subject: "тема_#{i}", content: "текст_#{i}")}
end

Пусть(/^я нажимаю на пост (\d+)$/) do |post_id|
  find(post_block(post_id)).click
end

Тогда(/^я (.*?)вижу диалог о сохранении и айди текущего поста должно быть (\d+)(?:, а текст-"(.*?)")?$/) do |i_see, post_id, text|
  expect(page).to have_css(SAVE_LIST, visible: i_see == '')
  expect(id_current_post).to eq(post_id.to_s)
  expect(page).to have_field('post_content', with: text) if text
end

Пусть(/^я (?:(не ))?вижу диалог о сохранении$/) do |i_see|
  expect(page).to have_css(SAVE_LIST, visible: i_see == '')
end

Пусть(/^я нажав на пост (\d+),изменив его,нажав на пост (\d+),вижу сохранение и текущий не должен измениться$/) do |first_post_id, second_post_id|
  step "я нажимаю на пост #{first_post_id}"
  step "я ввожу \"#{Post.find(first_post_id).content} - изменен\" в поле \"post_content\""
  step "я нажимаю на пост #{second_post_id}"
  step "я вижу диалог о сохранении и айди текущего поста должно быть #{first_post_id}"
end

Пусть(/^в базе долж(?:но|ен) быть (\d+) поста$/) do |count|
  expect(Post.count).to eq(count.to_i)
end

Пусть(/^пост (\d+) должен иметь текст "(.*?)" в базе$/) do |post_id, text|
  expect(Post.find(post_id).content).to eq(text)
end

Пусть(/^я (.*?)вижу диалог о сохранении и текущий пост должен быть новым(?:(.*?))?$/) do |i_see, should_be_blank|
  expect(page).to have_css(SAVE_LIST, visible: i_see == '')
  expect(find(FORM)['action']).to match(/\/posts$/)
  expect(find(FORM)['method']).to eq("post")
  ['post_subject', 'post_content'].each {|field| expect(page).to have_field(field, with: '')} if should_be_blank == ' и пустым'
end

Тогда(/^я на пост (\d+) нажав (?:(не ))?вижу диалог о сохранении$/) do |post_id, i_see|
  step "я нажимаю на пост #{post_id}"
  expect(page).to have_css(SAVE_LIST, visible: i_see == '')
  expect(page).to have_css('button#submit_current1_post', text: I18n.t(:yes))
end

