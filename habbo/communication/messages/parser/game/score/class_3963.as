package com.sulake.habbo.communication.messages.parser.game.score
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3963
   {
      
      private var var_1270:int;
      
      private var var_808:int;
      
      private var var_4726:int;
      
      private var _name:String;
      
      private var var_975:String;
      
      private var var_111:String;
      
      public function class_3963(param1:IMessageDataWrapper)
      {
         super();
         var_1270 = param1.readInteger();
         var_808 = param1.readInteger();
         var_4726 = param1.readInteger();
         _name = param1.readString();
         var_975 = param1.readString();
         var_111 = param1.readString();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get score() : int
      {
         return var_808;
      }
      
      public function get rank() : int
      {
         return var_4726;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

