package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.ISelectedRoomObjectData;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class CatalogObjectMover implements class_1829
   {
      
      private static const OVERLAY_SPRITE_NAME:String = "CatalogOverlaySprite";
      
      private var _roomEngine:IRoomEngine;
      
      private var var_39:class_1812;
      
      private var var_61:Boolean = false;
      
      public function CatalogObjectMover()
      {
         super();
      }
      
      public function set roomEngine(param1:IRoomEngine) : void
      {
         _roomEngine = param1;
      }
      
      public function set mainContainer(param1:class_1812) : void
      {
         var_39 = param1;
      }
      
      public function get state() : Boolean
      {
         return var_61;
      }
      
      public function dispose() : void
      {
         releaseOverlaySprite();
         var_39 = null;
         _roomEngine = null;
         var_61 = false;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function onMainContainerEvent(param1:class_1758, param2:class_1741, param3:ISelectedRoomObjectData) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         if(_roomEngine == null)
         {
            return;
         }
         var _loc5_:WindowMouseEvent = param1 as WindowMouseEvent;
         switch(param1.type)
         {
            case "WME_MOVE":
               if(param3 == null || param3.operation != "OBJECT_PLACE")
               {
                  return;
               }
               _loc4_ = _loc5_.stageX;
               _loc7_ = _loc5_.stageY;
               if(getIconSprite() == null)
               {
                  var _loc6_:class_2198 = getFurniImageResult(param3);
                  if(_loc6_ == null)
                  {
                     return;
                  }
                  createOverlaySprite(null.data);
               }
               var_61 = true;
               moveOverlaySprite(_loc4_,_loc7_);
               break;
            case "WME_OUT":
               if(var_61)
               {
                  if(_loc5_.localX >= 0 && _loc5_.localX < param1.target.width && _loc5_.localY >= 0 && _loc5_.localY < param1.target.height)
                  {
                     return;
                  }
                  resetIcon();
               }
         }
      }
      
      public function resetIcon() : void
      {
         if(var_61)
         {
            releaseOverlaySprite();
            var_61 = false;
         }
      }
      
      private function getFurniImageResult(param1:ISelectedRoomObjectData) : class_2198
      {
         if(param1 == null || _roomEngine == null)
         {
            return null;
         }
         if(param1.category == 10)
         {
            return _roomEngine.getFurnitureIcon(param1.typeId,this);
         }
         if(param1.category == 20)
         {
            return _roomEngine.getWallItemIcon(param1.typeId,this,param1.instanceData);
         }
         return null;
      }
      
      private function createOverlaySprite(param1:BitmapData) : void
      {
         if(param1 == null || var_39 == null || var_39.desktop == null || getIconSprite() != null)
         {
            return;
         }
         var _loc4_:Sprite = var_39.desktop.getDisplayObject() as Sprite;
         var _loc2_:Sprite = new Sprite();
         _loc2_.name = "CatalogOverlaySprite";
         _loc2_.mouseEnabled = false;
         _loc2_.visible = true;
         var _loc3_:Bitmap = new Bitmap(param1);
         _loc2_.addChild(_loc3_);
         _loc4_.addChild(_loc2_);
      }
      
      private function getIconSprite() : Sprite
      {
         if(var_39 == null || var_39.desktop == null)
         {
            return null;
         }
         var _loc2_:Sprite = var_39.desktop.getDisplayObject() as Sprite;
         return _loc2_.getChildByName("CatalogOverlaySprite") as Sprite;
      }
      
      private function moveOverlaySprite(param1:int, param2:int) : void
      {
         var _loc3_:Sprite = getIconSprite();
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.x = param1 - Math.round(_loc3_.width / 2);
         _loc3_.y = param2 - Math.round(_loc3_.height / 2);
      }
      
      private function releaseOverlaySprite() : void
      {
         if(var_39 == null || var_39.desktop == null || getIconSprite() == null)
         {
            return;
         }
         var _loc3_:Sprite = var_39.desktop.getDisplayObject() as Sprite;
         var _loc1_:Sprite = _loc3_.getChildByName("CatalogOverlaySprite") as Sprite;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:Bitmap = _loc1_.removeChildAt(0) as Bitmap;
         if(_loc2_ != null && _loc2_.bitmapData != null)
         {
            _loc2_.bitmapData.dispose();
         }
         _loc3_.removeChild(_loc3_.getChildByName("CatalogOverlaySprite"));
      }
   }
}

