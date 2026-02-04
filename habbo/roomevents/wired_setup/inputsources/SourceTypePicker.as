package com.sulake.habbo.roomevents.wired_setup.inputsources
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_2060;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class SourceTypePicker
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _container:IItemListWindow;
      
      private var var_254:class_2677;
      
      private var var_852:class_55 = new class_55();
      
      private var var_387:SourceTypeOption;
      
      private var var_2235:IRegionWindow;
      
      private var var_2269:SourceTypeOption = null;
      
      private var var_3023:SourceTypeOption = null;
      
      private var _disposed:Boolean = false;
      
      public function SourceTypePicker(param1:HabboUserDefinedRoomEvents, param2:IItemListWindow, param3:class_2677)
      {
         super();
         _roomEvents = param1;
         _container = param2;
         var_254 = param3;
         var_2235 = sourceOptionsList.getListItemAt(0) as IRegionWindow;
         sourceOptionsList.removeListItems();
      }
      
      public function initialize(param1:Array, param2:int) : void
      {
         if(var_387 != null)
         {
            var_387.deactivate();
            var_387 = null;
         }
         var_2269 = null;
         var_3023 = null;
         marginLeft.color = 4280427042;
         marginRight.color = 4280427042;
         var _loc3_:IItemListWindow = sourceOptionsList;
         _loc3_.removeListItems();
         for each(var _loc4_ in param1)
         {
            if(!var_852.hasKey(_loc4_))
            {
               var _loc5_:SourceTypeOption = new SourceTypeOption(this,var_2235.clone() as IRegionWindow,_loc4_);
               var_852.add(_loc4_,null);
            }
            else
            {
               _loc5_ = var_852.getValue(_loc4_);
            }
            if(var_2269 == null)
            {
               var_2269 = null;
            }
            var_3023 = null;
            _loc3_.addListItem(null.container);
            if(_loc4_ == param2)
            {
               var_387 = null;
            }
         }
         if(var_387 != null)
         {
            var_387.activate();
         }
         else if(param1.length > 0)
         {
            onClick(var_852.getValue(param1[0]));
         }
      }
      
      public function select(param1:int) : void
      {
         for each(var _loc2_ in var_852.getValues())
         {
            if(param1 == _loc2_.option)
            {
               onClick(_loc2_);
            }
         }
      }
      
      internal function colorHasUpdated(param1:SourceTypeOption) : void
      {
         if(param1 == var_2269)
         {
            marginLeft.color = 0xFF000000 | param1.backgroundColor();
         }
         if(param1 == var_3023)
         {
            marginRight.color = 0xFF000000 | param1.backgroundColor();
         }
      }
      
      public function set disabled(param1:Boolean) : void
      {
         var _loc2_:Number = param1 ? 0.5 : 1;
         marginLeft.blend = _loc2_;
         marginRight.blend = _loc2_;
         for each(var _loc3_ in var_852)
         {
            _loc3_.disabled = param1;
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         _container.visible = param1;
      }
      
      internal function onClick(param1:SourceTypeOption) : void
      {
         if(param1 == var_387)
         {
            return;
         }
         if(var_387 != null)
         {
            var_387.deactivate();
            var_387 = null;
         }
         if(param1 != null)
         {
            var_387 = param1;
            var_387.activate();
            var_254.sourceType = var_387.option;
         }
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_2235.dispose();
         var_2235 = null;
         for each(var _loc1_ in var_852.getValues())
         {
            _loc1_.dispose();
         }
         var_852.dispose();
         var_852 = null;
      }
      
      private function get marginLeft() : class_2060
      {
         return class_2060(_container.findChildByName("margin_item_color_left"));
      }
      
      private function get marginRight() : class_2060
      {
         return class_2060(_container.findChildByName("margin_item_color_right"));
      }
      
      private function get sourceOptionsList() : IItemListWindow
      {
         return IItemListWindow(_container.findChildByName("source_options_list"));
      }
   }
}

