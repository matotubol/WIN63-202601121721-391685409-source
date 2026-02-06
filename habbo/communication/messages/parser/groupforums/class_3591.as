package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3591 extends class_3590
   {
      
      private var var_1981:int;
      
      private var var_1911:int;
      
      private var var_3241:int;
      
      private var var_2771:int;
      
      private var var_4636:String;
      
      private var var_5111:String;
      
      private var var_4571:String;
      
      private var var_5148:String;
      
      private var var_5218:String;
      
      private var var_5238:Boolean;
      
      private var var_5194:Boolean;
      
      public function class_3591()
      {
         super();
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : class_3591
      {
         var _loc2_:class_3591 = new class_3591();
         class_3590.fillFromMessage(_loc2_,param1);
         _loc2_.var_1981 = param1.readInteger();
         _loc2_.var_1911 = param1.readInteger();
         _loc2_.var_3241 = param1.readInteger();
         _loc2_.var_2771 = param1.readInteger();
         _loc2_.var_4636 = param1.readString();
         _loc2_.var_5111 = param1.readString();
         _loc2_.var_4571 = param1.readString();
         _loc2_.var_5148 = param1.readString();
         _loc2_.var_5218 = param1.readString();
         _loc2_.var_5238 = param1.readBoolean();
         _loc2_.var_5194 = param1.readBoolean();
         return _loc2_;
      }
      
      public function get readPermissions() : int
      {
         return var_1981;
      }
      
      public function get postMessagePermissions() : int
      {
         return var_1911;
      }
      
      public function get postThreadPermissions() : int
      {
         return var_3241;
      }
      
      public function get moderatePermissions() : int
      {
         return var_2771;
      }
      
      public function get canRead() : Boolean
      {
         return var_4636.length == 0;
      }
      
      public function get canReport() : Boolean
      {
         return true;
      }
      
      public function get canPostMessage() : Boolean
      {
         return var_5111.length == 0;
      }
      
      public function get canPostThread() : Boolean
      {
         return var_4571.length == 0;
      }
      
      public function get canModerate() : Boolean
      {
         return var_5148.length == 0;
      }
      
      public function get canChangeSettings() : Boolean
      {
         return var_5238;
      }
      
      public function get isStaff() : Boolean
      {
         return var_5194;
      }
      
      public function get readPermissionError() : String
      {
         return var_4636;
      }
      
      public function get postMessagePermissionError() : String
      {
         return var_5111;
      }
      
      public function get postThreadPermissionError() : String
      {
         return var_4571;
      }
      
      public function get moderatePermissionError() : String
      {
         return var_5148;
      }
      
      public function get reportPermissionError() : String
      {
         return var_5218;
      }
   }
}

