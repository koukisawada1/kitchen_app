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
      email: "maikeru@maikeru.com",
      name: "マイケル",
      introduction: "料理するのが大好きです",
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "ro-ranndo@ro-ranndo.com",
      name: "ローランド",
      introduction: "最近料理始めました",
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "rea-do@rea-do.com",
      name: "レアード",
      introduction: "料理初心者ですがよろしくお願いします",
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "sugoya@sugiya.com",
      name: "杉谷",
      introduction: "元料理人です。よろしくお願いします",
      password: "password",
      password_confirmation: "password"
    },
    {
      email: "darubissyu@darubissyu.com",
      name: "ダルビッシュ",
      introduction: "元料理人です。よろしくお願いします",
      password: "password",
      password_confirmation: "password"
    }
  ]
  )
for i in 1..15 do
  Recipe.create!(
    [
      {
        user_id: rand(1..5),
        title: "レシピタイトル#{i}",
        body: "料理紹介文",
        price: rand(2..5) * 100,
        puantity: rand(1..4),
        material: "材料名#{i}",
        make: "作り方",
        genre_id: rand(1..5),
        tyep_id: rand(1..7)
      }
    ]
    )

