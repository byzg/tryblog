require 'spec_helper'

describe Post do
  context 'before_save' do
    context '#cover_blank_fields' do
      it 'create full blank post' do
        @post = Post.create
        expect(@post.subject).to eq(I18n.t('models.post.not_blank_fields.subject'))
        expect(@post.content).to eq(I18n.t('models.post.not_blank_fields.content'))
      end
      it 'create post with blank fields' do
        @post1 = Post.create(subject: "sub")
        expect(@post1.subject).to eq('sub')
        expect(@post1.content).to eq(I18n.t('models.post.not_blank_fields.content'))
        @post2 = Post.create(content: 'con')
        expect(@post2.subject).to eq(I18n.t('models.post.not_blank_fields.subject'))
        expect(@post2.content).to eq('con')
      end
    end
  end
end
