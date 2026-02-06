package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class WiredMovementsMessageEventParser implements IMessageParser
   {
      
      private var var_2233:Array;
      
      private var var_2208:Array;
      
      private var var_2448:Array;
      
      private var var_2436:Array;
      
      public function WiredMovementsMessageEventParser()
      {
         super();
      }
      
      private static function parseUserMove(param1:IMessageDataWrapper) : class_3627
      {
         var _loc4_:Number = param1.readInteger();
         var _loc5_:Number = param1.readInteger();
         var _loc12_:Number = param1.readInteger();
         var _loc10_:Number = param1.readInteger();
         var _loc6_:Number = Number(param1.readString());
         var _loc9_:Number = Number(param1.readString());
         var _loc7_:Number = param1.readInteger();
         var _loc11_:Number = param1.readInteger();
         var _loc2_:Number = param1.readInteger();
         var _loc3_:Number = param1.readInteger();
         var _loc8_:Number = param1.readInteger();
         return new class_3627(_loc7_,new Vector3d(_loc4_,_loc5_,_loc6_),new Vector3d(_loc12_,_loc10_,_loc9_),_loc11_ == 0 ? "mv" : "sld",_loc2_,_loc3_,_loc8_);
      }
      
      private static function parseFurniMove(param1:IMessageDataWrapper) : class_2946
      {
         var _loc3_:Number = param1.readInteger();
         var _loc4_:Number = param1.readInteger();
         var _loc10_:Number = param1.readInteger();
         var _loc8_:Number = param1.readInteger();
         var _loc5_:Number = Number(param1.readString());
         var _loc7_:Number = Number(param1.readString());
         var _loc6_:Number = param1.readInteger();
         var _loc2_:Number = param1.readInteger();
         var _loc9_:Number = param1.readInteger();
         return new class_2946(_loc6_,new Vector3d(_loc3_,_loc4_,_loc5_),new Vector3d(_loc10_,_loc8_,_loc7_),_loc2_,_loc9_);
      }
      
      private static function parseWallItemMove(param1:IMessageDataWrapper) : class_2769
      {
         var _loc4_:Number = param1.readInteger();
         var _loc6_:Boolean = param1.readBoolean();
         var _loc10_:int = param1.readInteger();
         var _loc9_:int = param1.readInteger();
         var _loc7_:int = param1.readInteger();
         var _loc8_:int = param1.readInteger();
         var _loc5_:int = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc11_:int = param1.readInteger();
         var _loc12_:int = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         return new class_2769(_loc4_,_loc6_,_loc10_,_loc9_,_loc7_,_loc8_,_loc5_,_loc2_,_loc11_,_loc12_,_loc3_);
      }
      
      private static function parseUserDirUpdate(param1:IMessageDataWrapper) : class_2476
      {
         var _loc3_:Number = param1.readInteger();
         var _loc2_:Number = param1.readInteger();
         var _loc4_:Number = param1.readInteger();
         return new class_2476(_loc3_,_loc2_,_loc4_);
      }
      
      public function flush() : Boolean
      {
         var_2233 = [];
         var_2208 = [];
         var_2448 = [];
         var_2436 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_2233 = [];
         var_2208 = [];
         var_2448 = [];
         var_2436 = [];
         var _loc2_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc2_)
         {
            var _loc3_:int = param1.readInteger();
            switch(0)
            {
               case 0:
                  var_2233.push(parseUserMove(param1));
                  break;
               case 1:
                  var_2208.push(parseFurniMove(param1));
                  break;
               case 2:
                  var_2448.push(parseWallItemMove(param1));
                  break;
               case 3:
                  var_2436.push(parseUserDirUpdate(param1));
            }
            _loc4_++;
         }
         return true;
      }
      
      public function get userMoves() : Array
      {
         return var_2233;
      }
      
      public function get furniMoves() : Array
      {
         return var_2208;
      }
      
      public function get wallItemMoves() : Array
      {
         return var_2448;
      }
      
      public function get userDirectionUpdates() : Array
      {
         return var_2436;
      }
   }
}

