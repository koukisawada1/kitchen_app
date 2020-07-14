Genre.create!(
  [
    {
      name: "和食"
    },
    {
      name: "洋食"
    },
    {
      name: "中華料理"
    },
    {
      name: "韓国料理"
    },
    {
      name: "その他"
    }
  ]
  )

Type.create!(
  [
    {
      name: "ご飯・麺・パン"
    },
    {
      name: "主菜"
    },
    {
      name: "副菜"
    },
    {
      name: "丼"
    },
    {
      name: "汁物・スープ"
    },
    {
      name: "お菓子・デサート"
    },
    {
      name: "その他"
    }
  ]
  )

User.create!(
  [
    {
      email: "1@1",
      name: "マイケル",
      introduction: "料理するのが大好きです",
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "2@2",
      name: "ローランド",
      introduction: "最近料理始めました",
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "3@3",
      name: "レアード",
      introduction: "料理初心者ですがよろしくお願いします",
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "4@4",
      name: "杉谷",
      introduction: "元料理人です。よろしくお願いします",
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "5@5",
      name: "ダルビッシュ",
      introduction: "元料理人です。よろしくお願いします",
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "6@6",
      name: "ネイマール",
      introduction: "中華料理が好きです。よろしくお願いします",
      password: "password",
      password_confirmation: "password"
    }
  ]
  )
for i in 1..15 do
  Recipe.create!(
    [
      {
        user_id: rand(1..6),
        title: "レシピタイトル#{i}",
        body: "料理紹介文",
        price: rand(2..5) * 100,
        quantity: rand(1..4),
        material: "材料名#{i}",
        make: "作り方",
        genre_id: rand(1..5),
        type_id: rand(1..7)
      }
    ]
    )
end
for i in 7..15 do
  User.create!(
    [
      {
        email: "#{i}@#{i}",
        name: "テスト#{i}",
        introduction: "中華料理が好きです。よろしくお願いします",
        password: "password",
        password_confirmation: "password"
      }
    ]
    )
end

for i in 1..15 do
  Like.create!(
    [
      {
        user_id: i,
        recipe_id: rand(1..5)
      },
      {
        user_id: i,
        recipe_id: rand(6..10)
      },
      {
        user_id: i,
        recipe_id: rand(11..15)
      }
    ]
    )
end

for i in 1..15 do
  Comment.create!(
    [
      {
        user_id: i,
        recipe_id: rand(1..5),
        comment: "とても美味しかったです#{i}"
      },
      {
        user_id: i,
        recipe_id: rand(6..10),
        comment: "簡単に出来ました#{i}"
      },
      {
        user_id: i,
        recipe_id: rand(11..15),
        comment: "また作ります！#{i}"
      }
    ]
    )
end

