package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.room.IStuffData;
   import package_50.class_3692;
   
   public class FuseObjectData
   {
      
      private var _name:String;
      
      private var var_197:int;
      
      private var var_25:int;
      
      private var var_26:int;
      
      private var var_4939:int;
      
      private var var_4195:int;
      
      private var var_385:int;
      
      private var var_81:int;
      
      private var var_4869:int;
      
      private var var_4771:Boolean;
      
      private var var_1966:IStuffData;
      
      public function FuseObjectData()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         _name = param1.readString();
         var_197 = param1.readInteger();
         var_25 = param1.readInteger();
         var_26 = param1.readInteger();
         var_4939 = param1.readInteger();
         var_4195 = param1.readInteger();
         var_385 = param1.readInteger();
         var_81 = param1.readInteger();
         var_4869 = param1.readInteger();
         var_4771 = param1.readBoolean();
         var_1966 = class_3692.parseStuffData(param1);
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_26;
      }
      
      public function get xDimension() : int
      {
         return var_4939;
      }
      
      public function get yDimension() : int
      {
         return var_4195;
      }
      
      public function get height() : int
      {
         return var_385;
      }
      
      public function get direction() : int
      {
         return var_81;
      }
      
      public function get altitude() : int
      {
         return var_4869;
      }
      
      public function get canStandOn() : Boolean
      {
         return var_4771;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1966;
      }
   }
}

