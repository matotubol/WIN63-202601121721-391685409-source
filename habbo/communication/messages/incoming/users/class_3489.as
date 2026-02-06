package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3489
   {
      
      private var _groupId:int;
      
      private var _groupName:String;
      
      private var var_2806:String;
      
      private var _primaryColor:String;
      
      private var _secondaryColor:String;
      
      private var var_5061:Boolean;
      
      private var var_1820:int;
      
      private var var_4042:Boolean;
      
      public function class_3489(param1:IMessageDataWrapper)
      {
         super();
         _groupId = param1.readInteger();
         _groupName = param1.readString();
         var_2806 = param1.readString();
         _primaryColor = param1.readString();
         _secondaryColor = param1.readString();
         var_5061 = param1.readBoolean();
         var_1820 = param1.readInteger();
         var_4042 = param1.readBoolean();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get badgeCode() : String
      {
         return var_2806;
      }
      
      public function get primaryColor() : String
      {
         return _primaryColor;
      }
      
      public function get secondaryColor() : String
      {
         return _secondaryColor;
      }
      
      public function get favourite() : Boolean
      {
         return var_5061;
      }
      
      public function get ownerId() : int
      {
         return var_1820;
      }
      
      public function get hasForum() : Boolean
      {
         return var_4042;
      }
   }
}

