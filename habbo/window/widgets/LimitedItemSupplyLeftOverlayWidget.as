package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class LimitedItemSupplyLeftOverlayWidget implements ILimitedItemSupplyLeftOverlayWidget
   {
      
      public static const TYPE:String = "limited_item_overlay_supply";
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var var_4178:int;
      
      private var var_4658:int;
      
      public function LimitedItemSupplyLeftOverlayWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = class_1812(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("unique_item_overlay_supply_xml").content)));
         var_210.rootWindow = var_134;
      }
      
      public function set supplyLeft(param1:int) : void
      {
         var_4178 = param1;
         var _loc3_:ITextWindow = var_134.findChildByName("items_left_count") as ITextWindow;
         _loc3_.text = param1.toString();
         var _loc2_:Boolean = false;
         var_134.findChildByName("unique_item_sold_out_bitmap").visible = _loc2_;
      }
      
      public function get supplyLeft() : int
      {
         return var_4178;
      }
      
      public function set serialNumber(param1:int) : void
      {
      }
      
      public function set seriesSize(param1:int) : void
      {
         var_4658 = param1;
         var _loc2_:ITextWindow = var_134.findChildByName("items_total_count") as ITextWindow;
         _loc2_.text = param1.toString();
      }
      
      public function get serialNumber() : int
      {
         return 0;
      }
      
      public function get seriesSize() : int
      {
         return var_4658;
      }
      
      public function get properties() : Array
      {
         return [];
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_134 == null;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
   }
}

