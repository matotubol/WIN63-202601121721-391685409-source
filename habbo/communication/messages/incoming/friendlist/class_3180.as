package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3180
   {
      
      private var var_2699:int;
      
      private var _avatarName:String;
      
      private var var_5210:String;
      
      private var var_5230:Boolean;
      
      private var var_5269:Boolean;
      
      private var var_5285:int;
      
      private var var_5255:String;
      
      private var var_5328:String;
      
      private var _realName:String;
      
      public function class_3180(param1:IMessageDataWrapper)
      {
         super();
         this.var_2699 = param1.readInteger();
         this._avatarName = param1.readString();
         this.var_5210 = param1.readString();
         this.var_5230 = param1.readBoolean();
         this.var_5269 = param1.readBoolean();
         param1.readString();
         this.var_5285 = param1.readInteger();
         this.var_5255 = param1.readString();
         this._realName = param1.readString();
      }
      
      public function get avatarId() : int
      {
         return this.var_2699;
      }
      
      public function get avatarName() : String
      {
         return this._avatarName;
      }
      
      public function get avatarMotto() : String
      {
         return this.var_5210;
      }
      
      public function get isAvatarOnline() : Boolean
      {
         return this.var_5230;
      }
      
      public function get canFollow() : Boolean
      {
         return this.var_5269;
      }
      
      public function get avatarGender() : int
      {
         return this.var_5285;
      }
      
      public function get avatarFigure() : String
      {
         return this.var_5255;
      }
      
      public function get lastOnlineDate() : String
      {
         return this.var_5328;
      }
      
      public function get realName() : String
      {
         return this._realName;
      }
   }
}

