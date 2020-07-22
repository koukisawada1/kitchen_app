// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require bootstrap-sprockets
//= require_tree .


$(function(){

// -----ハンバーガーメニュー-----
	$('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#sp-menu').fadeToggle();
    event.preventDefault();
     });
// -----ヘッダー検索フォーム-----
    $('.js-modal-open').on('click',function(){
        $('.js-modal').fadeIn();
        return false;
    });
    $('.js-modal-close').on('click',function(){
        $('.js-modal, .genre-modal, .type-modal, .tag-modal').fadeOut();
        return false;
    });
// -----ジャンル一覧モーダル------
    $('.genre-modal-open').on('click',function(){
        $('.genre-modal').fadeIn();
        return false;
    });
    $('.genre-modal-close, .type-modal-open, .tag-modal-open').on('click',function(){
        $('.genre-modal').fadeOut();
        return false;
    });
// -----種別一覧モーダル-----
    $('.type-modal-open').on('click',function(){
        $('.type-modal').fadeIn();
        return false;
    });
    $('.type-modal-close, .genre-modal-open, .tag-modal-open').on('click',function(){
        $('.type-modal').fadeOut();
        return false;
    });
// -----タグ一覧モーダル-----
    $('.tag-modal-open').on('click',function(){
        $('.tag-modal').fadeIn();
        return false;
    });
    $('.tag-modal-close, .genre-modal-open, .type-modal-open ').on('click',function(){
        $('.tag-modal').fadeOut();
        return false;
    });
//　-----コメントフォームモーダル-----
    $('.comment-modal-open').on('click',function(){
        $('.comment-modal-content').fadeIn();
        return false;
    });
    $('.comment-modal-close').on('click',function(){
        $('.comment-modal-content').fadeOut();
        return false;
    });
// -----フラッシュメッセージ削除ボタン-----
    $('.alert-close').on('click',function(){
        $('.alert').fadeOut();
        return false;
    });

    $(function() {
        var h = $(window).height();
  
        $('#wrap').css('display','none');
        $('.loader').height(h).css('display','block');
    });
  
    $(window).load(function () { //全ての読み込みが完了したら実行
        $('.loader').delay(600).fadeOut(300);
        $('#wrap').css('display', 'block');
    });

// -----レシピ/ユーザー画像プレビュー-----
    function readURL(input) {
        if(input.files && input.files[0]){
            var reader = new FileReader();
            reader.onload = function (e) {
                $('.image').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
    $("#recipe_image").change(function(){
        readURL(this);
    });
    $("#user_image").change(function(){
        readURL(this);
    });
});