package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ItemListController;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class RadioGroupPreset extends WiredUIPreset
   {
      
      private var _container:ISelectorWindow;
      
      private var var_1451:Vector.<RadioButtonPreset>;
      
      private var var_2252:Function;
      
      private var var_2526:Vector.<IItemListWindow>;
      
      private var var_517:int;
      
      public function RadioGroupPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:Function, param6:int = 1)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("radio_group_view") as ISelectorWindow;
         var_517 = param6;
         var _loc8_:int = 0;
         var _loc7_:IItemListWindow = null;
         if(var_517 > 0)
         {
            var_2526 = new Vector.<IItemListWindow>();
         }
         var_1451 = new Vector.<RadioButtonPreset>();
         for each(var _loc10_ in param4)
         {
            var _loc9_:RadioButtonPreset = param2.createRadioButton(_loc10_);
            var_1451.push(null);
            if(param6 > 1)
            {
               if(_loc8_ % param6 == 0)
               {
                  _loc7_ = param2.createLayout("horizontal_list_view") as IItemListWindow;
                  _loc7_.spacing = param3.genericHorizontalSpacing;
                  var_2526.push(_loc7_);
                  itemList.addListItem(_loc7_);
               }
               _loc7_.addListItem(null.window);
            }
            else
            {
               itemList.addListItem(null.window);
            }
            if(param5 != null)
            {
               null.radioButton.addEventListener("WE_SELECTED",onSelectionChange);
            }
            _loc8_++;
         }
         selected = 0;
         var_2252 = param5;
      }
      
      private function onSelectionChange(param1:class_1758) : void
      {
         if(var_2252 != null)
         {
            var_2252(selected);
         }
      }
      
      public function get selected() : int
      {
         return _container.getSelected().id;
      }
      
      public function set selected(param1:int) : void
      {
         var _loc2_:IRadioButtonWindow = _container.findChildByName(RadioButtonPreset.OPTION_PREFIX + param1) as IRadioButtonWindow;
         _container.setSelected(_loc2_);
      }
      
      public function setOptionDisabled(param1:int, param2:Boolean) : void
      {
         var_1451[param1].disabled = param2;
      }
      
      public function method_20(param1:int) : RadioButtonPreset
      {
         return var_1451[param1];
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
         itemList.width = param1;
         var _loc2_:int = (param1 - (var_517 - 1) * var_64.genericHorizontalSpacing) / var_517;
         var _loc3_:int = 0;
         for each(var _loc4_ in var_1451)
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
      
      private function get itemList() : ItemListController
      {
         return _container.findChildByName("radio_button_list") as ItemListController;
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override protected function get childPresets() : Array
      {
         return toArray(var_1451);
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
         var_1451 = null;
         var_2252 = null;
         var_2526 = null;
      }
   }
}

