package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.catalog.HabboCatalog;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class ProductGridItem implements class_2253
   {
      
      public static const GRID_ITEM_BORDER:String = "bg";
      
      protected var var_18:class_1812;
      
      private var var_608:IItemGrid;
      
      protected var _icon:class_2251;
      
      protected var var_1554:class_2251;
      
      private var _disposed:Boolean = false;
      
      private var var_627:Object;
      
      private var _catalog:HabboCatalog;
      
      public function ProductGridItem(param1:HabboCatalog)
      {
         _catalog = param1;
         super();
      }
      
      public function get view() : class_1812
      {
         return var_18;
      }
      
      public function set grid(param1:IItemGrid) : void
      {
         var_608 = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_608 = null;
         _icon = null;
         var_1554 = null;
         _catalog = null;
         if(var_18 != null)
         {
            var_18.dispose();
            var_18 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      protected function get catalog() : HabboCatalog
      {
         return _catalog;
      }
      
      public function activate() : void
      {
         if(!var_18)
         {
            return;
         }
         if(var_18.findChildByTag("ITEM_HILIGHT"))
         {
            var_18.findChildByTag("ITEM_HILIGHT").visible = true;
         }
         else
         {
            var_18.getChildByName("bg").style = 0;
         }
      }
      
      public function deactivate() : void
      {
         if(!var_18)
         {
            return;
         }
         if(var_18.findChildByTag("ITEM_HILIGHT"))
         {
            var_18.findChildByTag("ITEM_HILIGHT").visible = false;
         }
         else
         {
            var_18.getChildByName("bg").style = 3;
         }
      }
      
      public function set view(param1:class_1812) : void
      {
         if(!param1)
         {
            return;
         }
         var_18 = param1;
         var_18.procedure = eventProc;
         var_1554 = var_18.findChildByName("image_wide") as class_2251;
         if(var_1554)
         {
            var_18.findChildByName("wide_container").visible = useWideView;
            var_18.findChildByName("small_container").visible = !useWideView;
            var_18.width = useWideView ? var_18.limits.maxWidth : int(var_18.limits.minWidth);
         }
         else
         {
            var_1554 = _icon;
         }
         _icon = var_18.findChildByName("image") as class_2251;
         if(var_18.findChildByTag("ITEM_HILIGHT"))
         {
            var_18.findChildByTag("ITEM_HILIGHT").visible = false;
         }
         var _loc2_:class_1741 = var_18.findChildByName("multiContainer");
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      protected function get useWideView() : Boolean
      {
         return false;
      }
      
      public function setDraggable(param1:Boolean) : void
      {
         if(var_18 as IInteractiveWindow && param1)
         {
            (var_18 as IInteractiveWindow).setMouseCursorForState(4,5);
            (var_18 as IInteractiveWindow).setMouseCursorForState(4 | 1,5);
         }
      }
      
      private function eventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:Boolean = false;
         if(param1.type == "WME_UP")
         {
            var_627 = null;
         }
         else if(param1.type == "WME_DOWN")
         {
            if(param2 == null)
            {
               return;
            }
            var_608.select(this,true);
            var_627 = param2;
         }
         else if(param1.type == "WME_OUT" && var_627 != null && var_627 == param2)
         {
            _loc3_ = var_608.startDragAndDrop(this);
            if(_loc3_)
            {
               var_627 = null;
            }
         }
         else if(param1.type == "WME_UP")
         {
            var_627 = null;
         }
         else if(param1.type == "WME_CLICK")
         {
            var_627 = null;
         }
         else if(param1.type == "WME_DOUBLE_CLICK")
         {
            var_627 = null;
         }
      }
      
      public function setIconImage(param1:BitmapData, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:class_2251 = targetIcon;
         if(_loc5_ != null && !_loc5_.disposed)
         {
            _loc3_ = (_loc5_.width - param1.width) / 2;
            _loc4_ = (_loc5_.height - param1.height) / 2;
            if(_loc5_.bitmap == null)
            {
               _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,16777215);
            }
            else
            {
               _loc5_.bitmap.fillRect(_loc5_.bitmap.rect,16777215);
            }
            _loc5_.bitmap.copyPixels(param1,param1.rect,new Point(_loc3_,_loc4_),null,null,false);
            _loc5_.invalidate();
         }
         if(param2)
         {
            param1.dispose();
         }
      }
      
      protected function get targetIcon() : class_2251
      {
         return useWideView ? var_1554 : _icon;
      }
      
      protected function renderAvatarImage(param1:String, param2:class_259) : BitmapData
      {
         var _loc4_:class_1827 = _catalog.avatarRenderManager.createAvatarImage(param1,"h",null,param2);
         var _loc3_:BitmapData = _loc4_.getCroppedImage("head",0.5);
         _loc4_.dispose();
         return _loc3_;
      }
   }
}

