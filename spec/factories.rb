FactoryGirl.define do
  factory :user do
    name "John"
    rating1 0
    rating2 0
  end

  factory :user_with_invalid_symbols, :class => User do
    name "J_o_h_n"
    rating1 0
    rating2 0
  end

  factory :user_with_long_name, :class => User  do
    name "a" * 100
    rating1 0
    rating2 0
  end
end