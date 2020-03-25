```
> docker-compose build
> docker-compose run --rm app bundle install
> docker-compose run --rm app bundle exec rspec
```

Trailblazer gem provides a framework for building an architecture. It can be used with any other framework(Rails, sinatra, hanami). Here are some things that this gem is targeted to achieve:

- Encapsulate business logic in operation objects and keep it out of AR models/controllers
- Provide a consistent abstraction for operations/workflows/results
- Provide tools to build workflows from reusable steps
- Add integrations with well-known framework like Rails and useful gems like dry-rb and pundit

Pros:

- Has integrations with Rails
- Workflow syntax is clean and its easy to see the flow of operations
- Team also provides additional gems for validation, view reusability, json parsing
- Has a website with a bunch of examples and even a book about building apps using this gem

Cons:

- ActiveModel validation support is deprecated. It is recommended to use `dry-validation`. It means that you'd have to bring another gem. Tried to switch to `dry-validation` and hit an error due to different version of `dry` and `reform`
- `trailblazer` uses a lot of `dry-rb` gems and they are supported by different teams, so version conflicts can happen if releases are not communicated between teams
- Some example I tried to use from their documentation didn't work because API has changed


Two gems from `trailblazer` collection were used in this example:

- `trailblazer-operation` - code for modeling workflows and their results
- `reform` - Adding contracts and validation to `trailblazer-operation`. Also it defines a way to work with form objects

These gems don't add any constraints on code organization, only provide a uniform way to define operations. `reform` can be dropped and PORO form objects can be used + AcitveModel validations. 
