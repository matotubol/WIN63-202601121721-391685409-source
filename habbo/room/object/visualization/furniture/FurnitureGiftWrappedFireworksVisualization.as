package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureGiftWrappedFireworksVisualization extends FurnitureFireworksVisualization
   {
      
      private static const PRESENT_DEFAULT_STATE:int = 0;
      
      private static const MAX_PACKET_TYPE_VALUE:int = 9;
      
      private static const MAX_RIBBON_TYPE_VALUE:int = 11;
      
      private var var_4055:int = 0;
      
      private var var_4302:int = 0;
      
      private var var_61:int = 0;
      
      public function FurnitureGiftWrappedFireworksVisualization()
      {
         super();
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         updateTypes();
         super.update(param1,param2,param3,param4);
      }
      
      private function updateTypes() : void
      {
         var _loc6_:IRoomObjectModel = null;
         var _loc1_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:IRoomObject = object;
         if(_loc3_ != null)
         {
            _loc6_ = _loc3_.getModel();
            if(_loc6_ != null)
            {
               _loc1_ = 1000;
               _loc4_ = _loc6_.getString("furniture_extras");
               _loc5_ = parseInt(_loc4_);
               _loc2_ = Math.floor(_loc5_ / _loc1_);
               _loc7_ = _loc5_ % _loc1_;
               var_4055 = _loc2_ > 9 ? 0 : _loc2_;
               var_4302 = _loc7_ > 11 ? 0 : _loc7_;
            }
         }
      }
      
      override protected function getFrameNumber(param1:int, param2:int) : int
      {
         if(var_61 == 0)
         {
            if(param2 <= 1)
            {
               return var_4055;
            }
            if(param2 == 2)
            {
               return var_4302;
            }
         }
         return super.getFrameNumber(param1,param2);
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         var _loc3_:int = getSize(param1);
         var _loc4_:String = type;
         var _loc5_:String = "";
         if(param2 < spriteCount - 1)
         {
            _loc5_ = String.fromCharCode("a".charCodeAt() + param2);
         }
         else
         {
            _loc5_ = "sd";
         }
         var _loc6_:int = getFrameNumber(param1,param2);
         _loc4_ += "_" + _loc3_ + "_" + _loc5_ + "_" + direction;
         return _loc4_ + ("_" + _loc6_);
      }
      
      override protected function setAnimation(param1:int) : void
      {
         var_61 = param1;
         super.setAnimation(param1);
      }
   }
}

