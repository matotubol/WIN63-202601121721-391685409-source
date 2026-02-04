package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.class_3805;
   
   public class LimitedItemPreviewOverlayWidget implements ILimitedItemPreviewOverlayWidget
   {
      
      public static const TYPE:String = "limited_item_overlay_preview";
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var _serialNumber:int;
      
      private var var_4658:int;
      
      public function LimitedItemPreviewOverlayWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = class_1812(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("unique_item_overlay_preview_xml").content)));
         var_210.rootWindow = var_134;
      }
      
      public function set serialNumber(param1:int) : void
      {
         _serialNumber = param1;
         var _loc2_:class_2251 = class_2251(var_134.findChildByName("unique_item_serial_number_bitmap"));
         _loc2_.bitmap = class_3805.createBitmap(_windowManager.assets,serialNumber,_loc2_.width,_loc2_.height);
      }
      
      public function set seriesSize(param1:int) : void
      {
         var_4658 = param1;
         var _loc2_:class_2251 = class_2251(var_134.findChildByName("unique_item_edition_size_bitmap"));
         _loc2_.bitmap = class_3805.createBitmap(_windowManager.assets,param1,_loc2_.width,_loc2_.height);
      }
      
      public function get serialNumber() : int
      {
         return _serialNumber;
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

