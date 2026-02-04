package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.ISideContentModel;
   import package_24.class_3930;
   
   public class WardrobeModel implements ISideContentModel
   {
      
      private var var_55:HabboAvatarEditor;
      
      private var var_18:WardrobeView;
      
      private var var_122:class_55;
      
      private var var_265:Boolean = false;
      
      public function WardrobeModel(param1:HabboAvatarEditor)
      {
         super();
         var_55 = param1;
      }
      
      public function dispose() : void
      {
         var_55 = null;
         for each(var _loc1_ in var_122)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         var_122 = null;
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         var_265 = false;
      }
      
      public function reset() : void
      {
         var_265 = false;
      }
      
      private function init() : void
      {
         if(var_18)
         {
            var_18.dispose();
         }
         var_18 = new WardrobeView(this);
         if(var_55.handler != null)
         {
            var_55.handler.getWardrobe();
         }
         if(var_122)
         {
            for each(var _loc2_ in var_122)
            {
               _loc2_.dispose();
               _loc2_ = null;
            }
         }
         var_122 = new class_55();
         var _loc1_:int = 1;
         while(true)
         {
            var_122.add(0,new WardrobeSlot(var_18.slotWindowTemplate,var_55,0,isSlotEnabled(0)));
            _loc1_++;
         }
      }
      
      public function get controller() : HabboAvatarEditor
      {
         return var_55;
      }
      
      public function getWindowContainer() : class_1812
      {
         if(!var_265)
         {
            init();
         }
         return var_18.getWindowContainer();
      }
      
      private function updateView() : void
      {
         var_18.update();
      }
      
      public function updateSlots(param1:int, param2:Array) : void
      {
         var _loc3_:WardrobeSlot = null;
         if(!var_265)
         {
            return;
         }
         if(!param2)
         {
            ErrorReportStorage.addDebugData("WardrobeModel","updateSlots: outfits is null!");
         }
         if(!var_122)
         {
            ErrorReportStorage.addDebugData("WardrobeModel","updateSlots: _slots is null!");
         }
         for each(var _loc4_ in param2)
         {
            _loc3_ = var_122.getValue(_loc4_.slotId) as WardrobeSlot;
            if(_loc3_)
            {
               _loc3_.update(_loc4_.figureString,_loc4_.gender,isSlotEnabled(_loc3_.id));
            }
         }
      }
      
      private function isSlotEnabled(param1:int) : Boolean
      {
         if(param1 <= 5)
         {
            return var_55.manager.sessionData.hasClub;
         }
         return var_55.manager.sessionData.hasVip;
      }
      
      public function get slots() : Array
      {
         return var_122.getValues();
      }
   }
}

