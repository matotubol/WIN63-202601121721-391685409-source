package com.sulake.habbo.communication.login
{
   import flash.utils.Dictionary;
   
   public interface ILoginViewer
   {
      
      function getProperty(param1:String, param2:Dictionary = null) : String;
      
      function showLoginScreen() : void;
      
      function showRegistrationError(param1:Object) : void;
      
      function showInvalidLoginError(param1:Object) : void;
      
      function nameCheckResponse(param1:Object, param2:Boolean) : void;
      
      function showAccountError(param1:Object) : void;
      
      function showLoadingScreen() : void;
      
      function saveLooksError(param1:Object) : void;
      
      function showTOS() : void;
      
      function environmentReady() : void;
      
      function populateCharacterList(param1:Vector.<AvatarData>) : void;
      
      function showSelectAvatar(param1:Object) : void;
      
      function showPromoHabbos(param1:XML) : void;
      
      function showSelectRoom() : void;
      
      function showCaptchaError() : void;
      
      function createCaptchaView() : class_262;
      
      function captchaReady() : void;
   }
}

