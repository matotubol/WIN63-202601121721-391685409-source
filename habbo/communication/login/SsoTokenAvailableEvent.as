package com.sulake.habbo.communication.login
{
   import flash.events.Event;
   
   public class SsoTokenAvailableEvent extends Event
   {
      
      public static const SSO_TOKEN_AVAILABLE:String = "SSO_TOKEN_AVAILABLE";
      
      private var _ssoToken:String;
      
      public function SsoTokenAvailableEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _ssoToken = param2;
      }
      
      public function get ssoToken() : String
      {
         return _ssoToken;
      }
   }
}

