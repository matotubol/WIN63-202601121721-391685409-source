package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_4034 implements IMessageParser
   {
      
      private var var_3029:int;
      
      private var var_2715:int;
      
      private var var_2590:Array;
      
      public function class_4034()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3029 = -1;
         var_2715 = -1;
         var_2590 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3029 = param1.readInteger();
         var_2715 = param1.readInteger();
         var_2590 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2590.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get winningVoteCode() : int
      {
         return var_3029;
      }
      
      public function get ownVoteCode() : int
      {
         return var_2715;
      }
      
      public function get finalStatus() : Array
      {
         return var_2590;
      }
   }
}

