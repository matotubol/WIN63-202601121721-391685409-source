package com.sulake.habbo.communication.messages.parser.game.score
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_4072
   {
      
      private var _name:String;
      
      private var var_975:String;
      
      private var var_111:String;
      
      private var var_4726:int;
      
      private var var_808:int;
      
      public function class_4072(param1:IMessageDataWrapper)
      {
         super();
         _name = param1.readString();
         var_975 = param1.readString();
         var_111 = param1.readString();
         var_4726 = param1.readInteger();
         var_808 = param1.readInteger();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get rank() : int
      {
         return var_4726;
      }
      
      public function get score() : int
      {
         return var_808;
      }
   }
}

