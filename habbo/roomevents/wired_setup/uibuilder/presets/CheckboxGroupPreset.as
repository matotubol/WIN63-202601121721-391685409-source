package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CheckboxGroupPreset extends WiredUIPreset
   {
      
      private var _container:IItemListWindow;
      
      private var var_922:class_55;
      
      private var var_2252:Function;
      
      private var var_2526:Vector.<IItemListWindow>;
      
      private var var_517:int;
      
      public function CheckboxGroupPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:Function, param6:int = 1)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("vertical_list_view") as IItemListWindow;
         var_517 = param6;
         var_2252 = param5;
         var _loc9_:int = 0;
         var _loc7_:IItemListWindow = null;
         if(var_517 > 0)
         {
            var_2526 = new Vector.<IItemListWindow>();
         }
         var_922 = new class_55();
         for each(var _loc10_ in param4)
         {
            if(_loc10_.id == -1)
            {
               _loc10_.id = _loc9_;
            }
            var _loc8_:CheckboxOptionPreset = param2.createCheckboxOption(_loc10_);
            var_922.add(_loc10_.id,null);
            if(param6 > 1)
            {
               if(_loc9_ % param6 == 0)
               {
                  _loc7_ = param2.createLayout("horizontal_list_view") as IItemListWindow;
                  _loc7_.spacing = param3.genericHorizontalSpacing;
                  var_2526.push(_loc7_);
                  _container.addListItem(_loc7_);
               }
               _loc7_.addListItem(null.window);
            }
            else
            {
               _container.addListItem(null.window);
            }
            if(param5 != null)
            {
               null.checkbox.addEventListener("WE_SELECTED",onSelectionChange);
               null.checkbox.addEventListener("WE_UNSELECTED",onSelectionChange);
            }
            _loc9_++;
         }
      }
      
      private function onSelectionChange(param1:class_1758) : void
      {
         var _loc2_:int = 0;
         if(var_2252 != null)
         {
            _loc2_ = param1.window.id;
            var_2252(_loc2_,method_20(_loc2_).selected);
         }
      }
      
      public function method_20(param1:int) : CheckboxOptionPreset
      {
         return var_922.getValue(param1);
      }
      
      public function get numCheckboxes() : int
      {
         return var_922.length;
      }
      
      public function get mask() : int
      {
         for each(var _loc2_ in var_922.getValues())
         {
            if(_loc2_.selected)
            {
               var _loc1_:* = 0 | 1 << _loc2_.checkbox.id;
            }
         }
         return 0;
      }
      
      public function set mask(param1:int) : void
      {
         var _loc2_:* = false;
         for each(var _loc3_ in var_922.getValues())
         {
            _loc2_ = (param1 & 1 << _loc3_.checkbox.id) != 0;
            Util.select(_loc3_.checkbox,_loc2_);
         }
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
         var _loc2_:int = (param1 - (var_517 - 1) * var_64.genericHorizontalSpacing) / var_517;
         var _loc3_:int = 0;
         for each(var _loc4_ in var_922.getValues())
         {
            _loc4_.resizeToWidth(_loc2_);
            if(var_517 > 1)
            {
               var _loc5_:IItemListWindow = var_2526[int(_loc3_ / var_517)];
               if(_loc4_.window.height > null.height)
               {
                  null.height = _loc4_.window.height;
               }
            }
            _loc3_++;
         }
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override protected function get childPresets() : Array
      {
         return var_922.getValues();
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
         var_922 = null;
         var_2252 = null;
         var_2526 = null;
      }
   }
}

