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
      email: "test@test.com",
      name: "test",
      password: "password",
      password_confirmation: "password",
      )
