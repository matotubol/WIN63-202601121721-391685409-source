package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   public class Game2PlayerData implements class_13
   {
      
      private var var_3739:int;
      
      private var _userName:String;
      
      private var _figureString:String;
      
      private var var_111:String;
      
      private var var_3938:int;
      
      private var var_1134:Boolean = false;
      
      public function Game2PlayerData()
      {
         super();
      }
      
      public function dispose() : void
      {
         _userName = null;
         _figureString = null;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         var_3739 = param1.readInteger();
         _userName = param1.readString();
         _figureString = param1.readString();
         var_111 = param1.readString();
         var_3938 = param1.readInteger();
      }
      
      public function toString() : String
      {
         return "[Game Player] " + var_3739 + ": " + _userName;
      }
      
      public function get referenceId() : int
      {
         return var_3739;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get figureString() : String
      {
         return _figureString;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get teamId() : int
      {
         return var_3938;
      }
      
      public function get isDisposed() : Boolean
      {
         return var_1134;
      }
   }
}

