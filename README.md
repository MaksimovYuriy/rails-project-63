# HexletCode

![hexlet-check](https://github.com/MaksimovYuriy/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)
![CI](https://github.com/MaksimovYuriy/rails-project-63/actions/workflows/hexlet-check.yml)

Генератор форм

Гем позволяет удобно генерировать html-формы через написание небольшой программы.

## Usage

Пример использования:

Функция `form_for(user, **options, &block)` принимает на вход обязательно данные о пользователе и генерирует тэг `<form></form>`
**options - параметры тэга `<form>`, &block - содержимое тэга `<form>`

Пример блока:


```ruby
f.input :name
f.input :job, as: :text
```

Первый параметр блока - поле у пользователя, as - формат поля (input, textarea), далее дополнительные параметры, при наличии

Пример полного вызова функции:

```ruby
user = User.new name: 'rob', job: 'hexlet', gender: 'm'
result_string = HexletCode.form_for user, url: '#' do |f|
    f.input :job, as: :text, rows: 50, cols: 50
end
```

Результат выполнения (без переноса строки):

```html
<form action=\"#\" method=\"post\">
    <textarea name=\"job\" cols=\"50\" rows=\"50\">hexlet</textarea>
</form>
```
