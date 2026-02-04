package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class RarityItemPreviewOverlayWidget implements IRarityItemPreviewOverlayWidget
   {
      
      public static const TYPE:String = "rarity_item_overlay_preview";
      
      private static const const_469:String = "rarity_item_overlay_preview:level";
      
      private static const RARITY_LEVEL_DEFAULT:PropertyStruct = new PropertyStruct("rarity_item_overlay_preview:level",0,"int");
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var var_4033:int;
      
      private var _disposed:Boolean;
      
      private var var_4790:ITextWindow;
      
      public function RarityItemPreviewOverlayWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = class_1812(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("rarity_item_overlay_preview_xml").content)));
         var_4790 = var_134.findChildByName("level") as ITextWindow;
         var_210.rootWindow = var_134;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         var_4033 = param1;
         var_4790.caption = param1.toString();
      }
      
      public function get rarityLevel() : int
      {
         return var_4033;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(RARITY_LEVEL_DEFAULT.withValue(rarityLevel));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("rarity_item_overlay_preview:level" === _loc3_)
            {
               rarityLevel = int(_loc2_.value);
            }
         }
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
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
   }
}

