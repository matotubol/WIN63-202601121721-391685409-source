package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserNameChangedMessageEventParser implements IMessageParser
   {
      
      private var var_2707:int;
      
      private var var_197:int;
      
      private var _newName:String;
      
      public function UserNameChangedMessageEventParser()
      {
         super();
      }
      
      public function get webId() : int
      {
         return var_2707;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get newName() : String
      {
         return _newName;
      }
      
      public function flush() : Boolean
      {
         var_2707 = -1;
         var_197 = -1;
         _newName = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2707 = param1.readInteger();
         var_197 = param1.readInteger();
         _newName = param1.readString();
         return true;
      }
   }
}

