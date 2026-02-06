package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_2164;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_3348;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   
   [SecureSWF(rename="true")]
   public class GetGuestRoomResultEventParser implements IMessageParser, class_13
   {
      
      private var var_5226:Boolean;
      
      private var var_5174:Boolean;
      
      private var var_5184:Boolean;
      
      private var var_24:class_1945;
      
      private var var_5249:Boolean;
      
      private var var_2624:class_3348;
      
      private var var_2796:class_2164;
      
      private var var_5189:Boolean;
      
      public function GetGuestRoomResultEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_5226 = param1.readBoolean();
         this.var_24 = new class_1945(param1);
         this.var_5174 = param1.readBoolean();
         this.var_5184 = param1.readBoolean();
         this.var_5249 = param1.readBoolean();
         var _loc2_:Boolean = param1.readBoolean();
         this.var_2624 = new class_3348(param1);
         this.var_24.allInRoomMuted = _loc2_;
         this.var_24.canMute = param1.readBoolean();
         this.var_2796 = new class_2164(param1);
         this.var_5189 = param1.readBoolean();
         return true;
      }
      
      public function dispose() : void
      {
         var_2624 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_2624 == null;
      }
      
      public function get enterRoom() : Boolean
      {
         return var_5226;
      }
      
      public function get data() : class_1945
      {
         return var_24;
      }
      
      public function get roomForward() : Boolean
      {
         return var_5174;
      }
      
      public function get staffPick() : Boolean
      {
         return var_5184;
      }
      
      public function get isGroupMember() : Boolean
      {
         return var_5249;
      }
      
      public function get roomModerationSettings() : class_3348
      {
         return var_2624;
      }
      
      public function get openingConnection() : Boolean
      {
         return var_5189;
      }
      
      public function get chatSettings() : class_2164
      {
         return var_2796;
      }
   }
}

