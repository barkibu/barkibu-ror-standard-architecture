```
> docker-compose build
> docker-compose run --rm app bundle install
> docker-compose run --rm app bundle exec rspec
```

> dry-rb helps you write clear, flexible, and more maintainable Ruby code. Each dry-rb gem fulfils a common task, and together they make a powerful platform for any kind of Ruby application.

I've used `dry-validation` and `dry-monads` gems to create a use case of consultation creation.

> dry-validation is a data validation library that provides a powerful DSL for defining schemas and validation rules.
> Validations are expressed through contract objects. A contract specifies a schema with basic type checks and any additional rules that should be applied. Contract rules are applied only once the values they rely on have been succesfully verified by the schema.

Contract pattern is used from `dry-validation` gem. It provides a flexible DSL for defining requirements for incoming data, a way to validate dataset against those requirements and error messages generation. It can be used as a replacement for ActiveModel validations since it implements all validations of AM. It also has an integration with `dry-monads` to make validations a natural step of a workflow.

> dry-monads is a set of common monads for Ruby. Monads provide an elegant way of handling errors, exceptions and chaining functions so that the code is much more understandable and has all the error handling, without all the ifs and elses.

Using `Result` monads we can chain a set of actions and handle errors gracefully in railway-fashion. https://fsharpforfunandprofit.com/rop/ It seems to be simpler and more flexible than what `trailblazer` offers in terms of building workflows. Although the idea in two gems is similar(railway flow)

Pros of using `dry-rb`:

- A wide set of gems for other tasks and an integration between them.
- Gems are pretty minimalistic and don't overwhelm with possibilities. One gem is dedicated to one task only
- Nice website with documentation and a lot of examples

Cons:

- It doesn't have strong integration with rails. On the contrary, it offers a lot of functionality Rails already provides and suggest a different approach.
- It seems to me that a developer with prior experience of using `dry-rb` is essential here. Since its very different from Rails it takes some time understand the concepts and possibilities of these gems.
