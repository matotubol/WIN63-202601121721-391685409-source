package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.class_3805;
   
   public class RarityItemGridOverlayWidget implements IRarityItemGridOverlayWidget
   {
      
      public static const TYPE:String = "rarity_item_overlay_grid";
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var _disposed:Boolean;
      
      private var var_134:class_1812;
      
      private var var_4033:int;
      
      private var var_5374:IStaticBitmapWrapperWindow;
      
      public function RarityItemGridOverlayWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = class_1812(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("rarity_item_overlay_griditem_xml").content)));
         var_210.rootWindow = var_134;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         var_4033 = param1;
         var _loc2_:class_2251 = class_2251(var_134.findChildByName("rarity_item_overlay_plaque_number_bitmap"));
         _loc2_.bitmap = class_3805.createBitmap(_windowManager.assets,rarityLevel,_loc2_.width,_loc2_.height);
      }
      
      public function get rarityLevel() : int
      {
         return var_4033;
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
            if(var_210 != null)
            {
               var_210.rootWindow = null;
               var_210 = null;
            }
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
   }
}

