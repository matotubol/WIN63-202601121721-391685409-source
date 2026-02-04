package com.sulake.habbo.avatar.hotlooks
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.class_2582;
   import com.sulake.habbo.avatar.wardrobe.*;
   import flash.utils.Dictionary;
   import package_174.class_3011;
   import package_195.class_3651;
   import package_195.class_3684;
   
   public class HotLooksModel extends CategoryBaseModel implements class_2582
   {
      
      public static const CATEGORY_HOT_LOOKS:String = "hot_looks";
      
      public static const CATEGORY_MY_LOOKS:String = "my_looks";
      
      private static const MAXIMUM_HOT_LOOKS:int = 20;
      
      private var var_880:Dictionary;
      
      private var var_1808:class_3651;
      
      public function HotLooksModel(param1:HabboAvatarEditor)
      {
         super(param1);
         var_880 = new Dictionary();
         var_880["M"] = [];
         var_880["F"] = [];
         var_880["M.index"] = 0;
         var_880["F.index"] = 0;
         requestHotLooks(param1);
      }
      
      private function requestHotLooks(param1:HabboAvatarEditor) : void
      {
         if(param1.manager.communication)
         {
            var_1808 = new class_3651(onHotLooksMessage);
            param1.manager.communication.addHabboConnectionMessageEvent(var_1808);
            param1.manager.communication.connection.send(new class_3011(20));
         }
      }
      
      private function onHotLooksMessage(param1:class_3651) : void
      {
         for each(var _loc2_ in param1.getParser().hotLooks)
         {
            (var_880[_loc2_.gender.toUpperCase()] as Array).push(new Outfit(var_55,_loc2_.figureString,_loc2_.gender));
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(var_1808)
         {
            if(controller && controller.manager && controller.manager.communication)
            {
               controller.manager.communication.removeHabboConnectionMessageEvent(var_1808);
            }
            var_1808 = null;
         }
         var_880 = null;
      }
      
      override protected function init() : void
      {
         if(!var_18)
         {
            var_18 = new HotLooksView(this);
         }
         var_18.init();
         var_265 = true;
      }
      
      public function selectHotLook(param1:int) : void
      {
         var _loc2_:Array = var_880[var_55.gender];
         var _loc3_:Outfit = _loc2_[param1];
         if(_loc3_ != null)
         {
            if(_loc3_.figure == "")
            {
               return;
            }
            var_55.loadAvatarInEditor(_loc3_.figure,_loc3_.gender,var_55.clubMemberLevel);
         }
      }
      
      public function get hotLooks() : Array
      {
         return var_880[var_55.gender];
      }
      
      override public function switchCategory(param1:String = "") : void
      {
      }
      
      override public function getCategoryData(param1:String) : CategoryData
      {
         return null;
      }
      
      override public function selectPart(param1:String, param2:int) : void
      {
      }
   }
}

