package com.sulake.habbo.communication.login
{
   import com.sulake.habbo.communication.class_57;
   import flash.events.IEventDispatcher;
   
   public interface ILoginProvider extends IEventDispatcher
   {
      
      function closeCaptcha() : void;
      
      function init(param1:class_57) : void;
      
      function loginWithCredentials(param1:String, param2:String, param3:int = 0) : void;
      
      function loginWithCredentialsWeb(param1:String) : void;
      
      function selectAvatar(param1:int) : void;
      
      function selectAvatarUniqueid(param1:String) : void;
   }
}

