package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SimpleListViewPreset extends WiredUIPreset
   {
      
      private var _container:IItemListWindow;
      
      private var var_997:Vector.<WiredUIPreset>;
      
      private var var_1534:Boolean;
      
      private var var_1392:Boolean;
      
      public function SimpleListViewPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Boolean, param5:Array, param6:Boolean)
      {
         super(param1,param2,param3);
         _container = param4 ? param2.createLayout("vertical_list_view") as IItemListWindow : param2.createLayout("horizontal_list_view") as IItemListWindow;
         var_1534 = param4;
         var_1392 = param6;
         _container.spacing = param4 ? param3.genericHorizontalSpacing : param3.genericVerticalSpacing;
         var_997 = new Vector.<WiredUIPreset>();
         for each(var _loc7_ in param5)
         {
            var_997.push(_loc7_);
            _container.addListItem(_loc7_.window);
         }
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      public function set spacing(param1:int) : void
      {
         _container.spacing = param1;
      }
      
      public function set minHeight(param1:int) : void
      {
         _container.limits.minHeight = param1;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         super.resizeToWidth(param1);
         if(var_1534)
         {
            _container.width = param1;
            for each(_loc6_ in var_997)
            {
               _loc6_.resizeToWidth(param1);
            }
            if(var_1392)
            {
               throw new Exception("Centering vertical lists not implemented yet");
            }
         }
         else
         {
            _loc5_ = param1 - (var_997.length - 1) * _container.spacing;
            _loc3_ = 0;
            for each(_loc6_ in var_997)
            {
               if(_loc6_.hasStaticWidth())
               {
                  _loc5_ -= _loc6_.staticWidth;
               }
               else
               {
                  _loc3_ += 1;
               }
            }
            _loc7_ = Math.max(0,int(_loc5_ / _loc3_));
            _loc2_ = int(_container.limits.minHeight);
            for each(_loc6_ in var_997)
            {
               if(_loc6_.hasStaticWidth())
               {
                  _loc6_.resizeToWidth(_loc6_.staticWidth);
               }
               else
               {
                  _loc6_.resizeToWidth(_loc7_);
               }
               _loc4_ = _loc6_.window.height;
               if(_loc4_ > _loc2_)
               {
                  _loc2_ = _loc4_;
               }
            }
            if(var_1392)
            {
               for each(_loc6_ in var_997)
               {
                  _loc6_.window.y = _loc2_ / 2 - _loc6_.window.height / 2;
               }
            }
            _container.height = _loc2_;
         }
      }
      
      public function set backgroundColor(param1:uint) : void
      {
         _container.background = true;
         _container.color = 0xFF000000 | param1;
      }
      
      override protected function get childPresets() : Array
      {
         return toArray(var_997);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         var_997 = null;
      }
   }
}

