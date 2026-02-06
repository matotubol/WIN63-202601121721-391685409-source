package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2228
   {
      
      private var var_1270:int;
      
      private var _userName:String;
      
      private var var_975:String;
      
      private var var_3144:String;
      
      private var var_3921:String;
      
      private var _achievementScore:int;
      
      private var var_4441:int;
      
      private var var_4262:Boolean;
      
      private var var_2996:Boolean;
      
      private var var_4252:Boolean;
      
      private var var_2078:Array = [];
      
      private var var_5056:int;
      
      private var var_4149:Boolean;
      
      private var var_4867:Boolean;
      
      private var var_3905:int;
      
      private var var_5221:int;
      
      private var var_4861:int;
      
      private var var_5245:Boolean;
      
      private var var_5223:Boolean;
      
      public function class_2228(param1:IMessageDataWrapper)
      {
         super();
         var_1270 = param1.readInteger();
         _userName = param1.readString();
         var_975 = param1.readString();
         var_3144 = param1.readString();
         var_3921 = param1.readString();
         _achievementScore = param1.readInteger();
         var_4441 = param1.readInteger();
         var_4262 = param1.readBoolean();
         var_2996 = param1.readBoolean();
         var_4252 = param1.readBoolean();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2078.push(new class_3489(param1));
            _loc3_++;
         }
         var_5056 = param1.readInteger();
         var_4149 = param1.readBoolean();
         var_4867 = param1.readBoolean();
         var_3905 = param1.readInteger();
         var_5221 = param1.readInteger();
         var_4861 = param1.readInteger();
         var_5245 = param1.readBoolean();
         var_5223 = param1.readBoolean();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get isHidden() : Boolean
      {
         return var_4867;
      }
      
      public function get motto() : String
      {
         return var_3144;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get creationDate() : String
      {
         return var_3921;
      }
      
      public function get achievementScore() : int
      {
         return _achievementScore;
      }
      
      public function get friendCount() : int
      {
         return var_4441;
      }
      
      public function get isFriend() : Boolean
      {
         return var_4262;
      }
      
      public function get isFriendRequestSent() : Boolean
      {
         return var_2996;
      }
      
      public function get isOnline() : Boolean
      {
         return var_4252;
      }
      
      public function get guilds() : Array
      {
         return var_2078;
      }
      
      public function set isFriendRequestSent(param1:Boolean) : void
      {
         var_2996 = param1;
      }
      
      public function get lastAccessSinceInSeconds() : int
      {
         return var_5056;
      }
      
      public function get openProfileWindow() : Boolean
      {
         return var_4149;
      }
      
      public function get accountLevel() : int
      {
         return var_3905;
      }
      
      public function get starGemCount() : int
      {
         return var_4861;
      }
   }
}

