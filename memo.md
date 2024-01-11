# TODO

## 修正
+ Render上でMailgunを使えるように環境変数を設定
  + production.rbも修正

## リファクタ
+ checkoutsコントローラのbuid_orderアクションでやっている購入者情報の名前、住所のデータ整形の処理を、orderモデルに移植
+ プロモーションコードのusedカラムの更新処理をpromotion_codeモデルに移植
+ applicationコントローラのset_cart_detailsアクションをモデルに移植
  + 複数のコントローラで使用されているので、どのモデルに移植すべきか、共通化してincludeすべきか要検討