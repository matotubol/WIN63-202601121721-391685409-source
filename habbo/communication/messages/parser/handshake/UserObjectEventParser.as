package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserObjectEventParser implements IMessageParser
   {
      
      private var var_197:int;
      
      private var _name:String;
      
      private var var_975:String;
      
      private var var_1309:String;
      
      private var var_5193:String;
      
      private var _realName:String;
      
      private var var_5229:Boolean;
      
      private var var_4065:int;
      
      private var var_868:int;
      
      private var var_1113:int;
      
      private var var_5234:Boolean;
      
      private var var_5211:String;
      
      private var var_1858:Boolean;
      
      private var var_2835:Boolean = false;
      
      private var var_4380:Boolean = false;
      
      private var var_3984:String = "";
      
      private var var_2340:int = 0;
      
      private var var_4717:int = 3;
      
      public function UserObjectEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_197 = param1.readInteger();
         this._name = param1.readString();
         this.var_975 = param1.readString();
         this.var_1309 = param1.readString();
         this.var_5193 = param1.readString();
         this._realName = param1.readString();
         this.var_5229 = param1.readBoolean();
         this.var_4065 = param1.readInteger();
         this.var_868 = param1.readInteger();
         this.var_1113 = param1.readInteger();
         this.var_5234 = param1.readBoolean();
         this.var_5211 = param1.readString();
         this.var_1858 = param1.readBoolean();
         this.var_2835 = param1.readBoolean();
         if(param1.bytesAvailable > 0)
         {
            var_4380 = param1.readBoolean();
            var_3984 = param1.readString();
         }
         if(param1.bytesAvailable > 0)
         {
            var_2340 = param1.readInteger();
            var_4717 = param1.readInteger();
         }
         return true;
      }
      
      public function get id() : int
      {
         return this.var_197;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get figure() : String
      {
         return this.var_975;
      }
      
      public function get sex() : String
      {
         return this.var_1309;
      }
      
      public function get customData() : String
      {
         return this.var_5193;
      }
      
      public function get realName() : String
      {
         return this._realName;
      }
      
      public function get directMail() : Boolean
      {
         return this.var_5229;
      }
      
      public function get respectTotal() : int
      {
         return this.var_4065;
      }
      
      public function get respectLeft() : int
      {
         return this.var_868;
      }
      
      public function get petRespectLeft() : int
      {
         return this.var_1113;
      }
      
      public function get streamPublishingAllowed() : Boolean
      {
         return this.var_5234;
      }
      
      public function get lastAccessDate() : String
      {
         return this.var_5211;
      }
      
      public function get nameChangeAllowed() : Boolean
      {
         return this.var_1858;
      }
      
      public function get accountSafetyLocked() : Boolean
      {
         return var_2835;
      }
      
      public function get accountTradeLocked() : Boolean
      {
         return var_4380;
      }
      
      public function get nameColor() : String
      {
         return var_3984;
      }
      
      public function get respectReplenishesLeft() : int
      {
         return var_2340;
      }
      
      public function get maxRespectPerDay() : int
      {
         return var_4717;
      }
   }
}

