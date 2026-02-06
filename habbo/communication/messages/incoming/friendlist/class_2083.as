package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2083
   {
      
      private var var_197:int;
      
      private var _name:String;
      
      private var var_111:int;
      
      private var var_3279:Boolean;
      
      private var var_3136:Boolean;
      
      private var var_975:String;
      
      private var var_2851:int;
      
      private var var_3144:String;
      
      private var var_2995:String;
      
      private var _realName:String;
      
      private var var_5273:String;
      
      private var var_3260:Boolean;
      
      private var var_2731:Boolean;
      
      private var var_3259:Boolean;
      
      private var _relationshipStatus:int;
      
      public function class_2083(param1:IMessageDataWrapper)
      {
         super();
         this.var_197 = param1.readInteger();
         this._name = param1.readString();
         this.var_111 = param1.readInteger();
         this.var_3279 = param1.readBoolean();
         this.var_3136 = param1.readBoolean();
         this.var_975 = param1.readString();
         this.var_2851 = param1.readInteger();
         this.var_3144 = param1.readString();
         this._realName = param1.readString();
         this.var_5273 = param1.readString();
         this.var_3260 = param1.readBoolean();
         this.var_2731 = param1.readBoolean();
         this.var_3259 = param1.readBoolean();
         this._relationshipStatus = param1.readShort();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get gender() : int
      {
         return var_111;
      }
      
      public function get online() : Boolean
      {
         return var_3279;
      }
      
      public function get followingAllowed() : Boolean
      {
         return var_3136;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get categoryId() : int
      {
         return var_2851;
      }
      
      public function get motto() : String
      {
         return var_3144;
      }
      
      public function get lastAccess() : String
      {
         return var_2995;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function get facebookId() : String
      {
         return var_5273;
      }
      
      public function get persistedMessageUser() : Boolean
      {
         return var_3260;
      }
      
      public function get vipMember() : Boolean
      {
         return var_2731;
      }
      
      public function get pocketHabboUser() : Boolean
      {
         return var_3259;
      }
      
      public function get relationshipStatus() : int
      {
         return _relationshipStatus;
      }
   }
}

