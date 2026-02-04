package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.class_2119;
   import flash.display.BitmapData;
   
   public class WallAdRasterizer extends WallRasterizer
   {
      
      public function WallAdRasterizer()
      {
         super();
      }
      
      override public function getTextureIdentifier(param1:Number, param2:IVector3d) : String
      {
         return String(param1);
      }
      
      override protected function initializePlanes() : void
      {
         if(data == null)
         {
            return;
         }
         var _loc1_:XMLList = data.wallAds;
         if(_loc1_.length() > 0)
         {
            parseWalls(_loc1_[0]);
         }
      }
      
      override protected function parseWalls(param1:XML) : void
      {
         var _loc5_:int = 0;
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc2_:XMLList = null;
         var _loc3_:WallPlane = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:XMLList = param1.wallAd;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length())
         {
            _loc6_ = _loc4_[_loc5_];
            if(class_2119.checkRequiredAttributes(_loc6_,["id"]))
            {
               _loc7_ = _loc6_.@id;
               _loc2_ = _loc6_.visualization;
               _loc3_ = new WallPlane();
               parseVisualizations(_loc3_,_loc2_);
               if(getPlane(_loc7_) == null)
               {
                  addPlane(_loc7_,_loc3_);
               }
               else
               {
                  _loc3_.dispose();
               }
            }
            _loc5_++;
         }
      }
      
      override public function render(param1:BitmapData, param2:String, param3:Number, param4:Number, param5:Number, param6:IVector3d, param7:Boolean, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:int = 0) : PlaneBitmapData
      {
         var _loc15_:WallPlane = getPlane(param2) as WallPlane;
         if(_loc15_ == null)
         {
            _loc15_ = getPlane("default") as WallPlane;
         }
         if(_loc15_ == null)
         {
            return null;
         }
         if(param1 != null)
         {
            param1.fillRect(param1.rect,16777215);
         }
         var _loc14_:BitmapData = _loc15_.render(param1,param3,param4,param5,param6,param7);
         if(_loc14_ != null && _loc14_ != param1)
         {
            _loc14_ = _loc14_.clone();
         }
         return new PlaneBitmapData(_loc14_,-1);
      }
   }
}

