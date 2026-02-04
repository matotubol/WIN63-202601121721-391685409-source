package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.IOutfit;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import flash.display.BitmapData;
   
   public class Outfit implements IOutfit, class_259
   {
      
      private var var_55:HabboAvatarEditor;
      
      private var var_975:String;
      
      private var var_111:String;
      
      private var var_18:OutfitView;
      
      private var var_1134:Boolean;
      
      public function Outfit(param1:HabboAvatarEditor, param2:String, param3:String)
      {
         super();
         var_55 = param1;
         var_18 = new OutfitView(param1.manager.windowManager,param1.manager.assets,param2 != "");
         switch(param3)
         {
            case "M":
            case "m":
            case "M":
               param3 = "M";
               break;
            case "F":
            case "f":
            case "F":
               param3 = "F";
         }
         var_975 = param2;
         var_111 = param3;
         update();
      }
      
      public function dispose() : void
      {
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         var_975 = null;
         var_111 = null;
         var_1134 = true;
         var_55 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function update() : void
      {
         var _loc1_:BitmapData = null;
         var _loc3_:Boolean = var_55.manager.getBoolean("zoom.enabled");
         var _loc2_:class_1827 = var_55.manager.avatarRenderManager.createAvatarImage(figure,_loc3_ ? "h" : "sh",var_111,this);
         if(_loc2_)
         {
            _loc2_.setDirection("full",4);
            _loc1_ = _loc2_.getImage("full",true,_loc3_ ? 0.5 : 1);
            if(var_18 && _loc1_)
            {
               var_18.update(_loc1_);
            }
            _loc2_.dispose();
         }
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get view() : OutfitView
      {
         return var_18;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         update();
      }
   }
}

