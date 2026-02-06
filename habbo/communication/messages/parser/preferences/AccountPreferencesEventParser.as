package com.sulake.habbo.communication.messages.parser.preferences
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AccountPreferencesEventParser implements IMessageParser
   {
      
      private var _traxVolume:int;
      
      private var _furniVolume:int;
      
      private var _uiVolume:int;
      
      private var var_3172:Boolean;
      
      private var var_2896:Boolean;
      
      private var var_3082:Boolean;
      
      private var var_685:int;
      
      private var var_2641:int;
      
      private var var_2772:Boolean;
      
      private var var_2975:Boolean;
      
      private var var_2234:Boolean;
      
      private var var_3018:Boolean;
      
      private var var_3164:Boolean;
      
      public function AccountPreferencesEventParser()
      {
         super();
      }
      
      public function get traxVolume() : int
      {
         return _traxVolume;
      }
      
      public function get furniVolume() : int
      {
         return _furniVolume;
      }
      
      public function get uiVolume() : int
      {
         return _uiVolume;
      }
      
      public function get freeFlowChatDisabled() : Boolean
      {
         return var_3172;
      }
      
      public function get roomInvitesIgnored() : Boolean
      {
         return var_2896;
      }
      
      public function get roomCameraFollowDisabled() : Boolean
      {
         return var_3082;
      }
      
      public function get uiFlags() : int
      {
         return var_685;
      }
      
      public function get preferedChatStyle() : int
      {
         return var_2641;
      }
      
      public function get wiredMenuButton() : Boolean
      {
         return var_2772;
      }
      
      public function get wiredInspectButton() : Boolean
      {
         return var_2975;
      }
      
      public function get playTestMode() : Boolean
      {
         return var_2234;
      }
      
      public function get wiredWhisperDisabled() : Boolean
      {
         return var_3018;
      }
      
      public function get showAllNotifications() : Boolean
      {
         return var_3164;
      }
      
      public function flush() : Boolean
      {
         var_3172 = false;
         var_3082 = false;
         var_685 = 0;
         var_2641 = 0;
         var_2772 = false;
         var_2975 = false;
         var_2234 = false;
         var_3018 = false;
         var_3164 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _uiVolume = param1.readInteger();
         _furniVolume = param1.readInteger();
         _traxVolume = param1.readInteger();
         var_3172 = param1.readBoolean();
         var_2896 = param1.readBoolean();
         var_3082 = param1.readBoolean();
         var_685 = param1.readInteger();
         var_2641 = param1.readInteger();
         var_2772 = param1.readBoolean();
         var_2975 = param1.readBoolean();
         var_2234 = param1.readBoolean();
         param1.readInteger();
         var_3018 = param1.readBoolean();
         if(param1.bytesAvailable > 0)
         {
            var_3164 = param1.readBoolean();
         }
         return true;
      }
   }
}

