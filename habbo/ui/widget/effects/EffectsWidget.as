package com.sulake.habbo.ui.widget.effects
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.class_3487;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.memenu.class_2303;
   import com.sulake.habbo.window.class_38;
   import flash.geom.Rectangle;
   
   public class EffectsWidget extends RoomWidgetBase
   {
      
      private static const LIST_HEIGHT_MAX:int = 320;
      
      private static const LIST_HEIGHT_MIN:int = 48;
      
      private static const TOOLBAR_MARGIN:int = 2;
      
      private var var_18:class_1812;
      
      private var var_121:IScrollableListWindow;
      
      private var var_737:class_55;
      
      public function EffectsWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40)
      {
         super(param1,param2,param3);
         this.handler.widget = this;
         var_737 = new class_55();
      }
      
      public function get handler() : class_3487
      {
         return var_41 as class_3487;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_737)
         {
            for each(var _loc1_ in var_737)
            {
               _loc1_.dispose();
            }
            var_737.dispose();
            var_737 = null;
         }
         var_121 = null;
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         super.dispose();
      }
      
      public function open() : void
      {
         var _loc2_:XmlAsset = null;
         if(!var_18)
         {
            _loc2_ = assets.getAssetByName("effects_widget") as XmlAsset;
            var_18 = windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
            var _loc1_:Rectangle = handler.container.toolbar.getRect();
            var_18.x = null.right + 2;
            var_18.y = null.bottom - var_18.height;
            var_121 = var_18.findChildByName("list") as IScrollableListWindow;
            var _loc3_:class_1741 = var_18.findChildByName("close");
            null.addEventListener("WME_CLICK",onClose);
         }
         update();
         var_18.visible = true;
      }
      
      public function update() : void
      {
         var _loc1_:EffectView = null;
         var _loc4_:int = 0;
         var _loc2_:Array = this.handler.container.inventory.getAvatarEffects();
         for each(var _loc3_ in _loc2_)
         {
            _loc1_ = var_737.getValue(_loc3_.type) as EffectView;
            if(_loc1_)
            {
               _loc1_.update();
            }
            else
            {
               _loc1_ = new EffectView(this,_loc3_);
               var_737.add(_loc3_.type,_loc1_);
               var_121.addListItem(_loc1_.window);
            }
         }
         _loc4_ = var_737.length - 1;
         while(_loc4_ >= 0)
         {
            _loc1_ = var_737.getWithIndex(_loc4_);
            if(_loc2_.indexOf(_loc1_.effect) == -1)
            {
               var_121.removeListItem(_loc1_.window);
               var_737.remove(var_737.getKey(_loc4_));
               _loc1_.dispose();
            }
            _loc4_--;
         }
         var _loc5_:int = int(var_121.scrollableRegion.height);
         var_121.height = Math.max(Math.min(_loc5_,320),48);
         var_18.findChildByName("no_effects").visible = _loc2_.length == 0;
      }
      
      public function selectEffect(param1:int, param2:Boolean) : void
      {
         if(param2)
         {
            handler.container.inventory.setEffectDeselected(param1);
         }
         else
         {
            handler.container.inventory.setEffectSelected(param1);
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         var_18.visible = false;
      }
   }
}

