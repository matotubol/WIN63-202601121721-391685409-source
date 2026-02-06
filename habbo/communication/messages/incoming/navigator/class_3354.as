package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class class_3354 implements class_13
   {
      
      private var var_919:int;
      
      private var var_1160:int;
      
      private var var_411:Array = [];
      
      private var _disposed:Boolean;
      
      public function class_3354(param1:IMessageDataWrapper)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var_919 = param1.readInteger();
         var_1160 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc2_)
         {
            var _loc3_:class_3691 = new class_3691();
            null.pos = param1.readInteger();
            null.imgId = param1.readInteger();
            var_411.push(null);
            _loc4_++;
         }
         if(var_919 == 0)
         {
            setDefaults();
         }
      }
      
      public function setDefaults() : void
      {
         var_919 = 1;
         var_1160 = 0;
         var _loc1_:class_3691 = new class_3691();
         _loc1_.pos = 4;
         _loc1_.imgId = 1;
         var_411.push(_loc1_);
      }
      
      public function getCopy() : class_3354
      {
         var _loc1_:class_3354 = new class_3354(null);
         _loc1_.var_919 = this.var_919;
         _loc1_.var_1160 = this.var_1160;
         for each(var _loc2_ in var_411)
         {
            _loc1_.var_411.push(_loc2_.getCopy());
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         this.var_411 = null;
      }
      
      public function getAsString() : String
      {
         var _loc1_:String = var_1160 + ";";
         _loc1_ += var_919 + ";";
         for each(var _loc2_ in var_411)
         {
            _loc1_ += _loc2_.imgId + "," + _loc2_.pos + ";";
         }
         return _loc1_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get bgImgId() : int
      {
         return var_919;
      }
      
      public function get frontImgId() : int
      {
         return var_1160;
      }
      
      public function get objects() : Array
      {
         return var_411;
      }
      
      public function set bgImgId(param1:int) : void
      {
         var_919 = param1;
      }
      
      public function set frontImgId(param1:int) : void
      {
         var_1160 = param1;
      }
   }
}

