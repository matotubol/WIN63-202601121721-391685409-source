package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.room.utils.Vector3d;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_2979;
   
   [SecureSWF(rename="true")]
   public class SlideObjectBundleMessageEventParser implements IMessageParser
   {
      
      private var var_197:int;
      
      private var var_2643:Array;
      
      private var var_213:class_2979 = null;
      
      public function SlideObjectBundleMessageEventParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get avatar() : class_2979
      {
         return var_213;
      }
      
      public function get objectList() : Array
      {
         return var_2643;
      }
      
      public function flush() : Boolean
      {
         var_197 = -1;
         var_213 = null;
         var_2643 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc12_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1 == null)
         {
            return false;
         }
         var _loc10_:Number = param1.readInteger();
         var _loc11_:Number = param1.readInteger();
         var _loc5_:Number = param1.readInteger();
         var _loc4_:Number = param1.readInteger();
         var _loc8_:int = param1.readInteger();
         var_2643 = [];
         var _loc6_:int = 0;
         while(0 < _loc8_)
         {
            var _loc14_:int = param1.readInteger();
            _loc12_ = Number(param1.readString());
            _loc3_ = Number(param1.readString());
            var _loc2_:Vector3d = new Vector3d(_loc10_,_loc11_,_loc12_);
            var _loc9_:Vector3d = new Vector3d(_loc5_,_loc4_,_loc3_);
            var _loc7_:class_2979 = new class_2979(0,null,null);
            var_2643.push(null);
            _loc6_++;
         }
         var_197 = param1.readInteger();
         if(!param1.bytesAvailable)
         {
            return true;
         }
         var _loc13_:int;
         switch(_loc13_ = param1.readInteger())
         {
            default:
               class_21.log("** Incompatible character movetype!");
               break;
            case 1:
               _loc14_ = param1.readInteger();
               _loc12_ = Number(param1.readString());
               _loc3_ = Number(param1.readString());
               _loc2_ = new Vector3d(_loc10_,_loc11_,_loc12_);
               _loc9_ = new Vector3d(_loc5_,_loc4_,_loc3_);
               var_213 = new class_2979(0,null,null,"mv");
               break;
            case 2:
               _loc14_ = param1.readInteger();
               _loc12_ = Number(param1.readString());
               _loc3_ = Number(param1.readString());
               _loc2_ = new Vector3d(_loc10_,_loc11_,_loc12_);
               _loc9_ = new Vector3d(_loc5_,_loc4_,_loc3_);
               var_213 = new class_2979(0,null,null,"sld");
               break;
            case 0:
         }
         return true;
      }
   }
}

