package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2143;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.IOutfit;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class WardrobeSlot implements IOutfit, class_259
   {
      
      private var var_55:HabboAvatarEditor;
      
      private var var_975:String;
      
      private var var_111:String;
      
      private var var_3091:Boolean;
      
      private var var_18:class_1812;
      
      private var var_742:class_2251;
      
      private var var_2895:int;
      
      private var var_1134:Boolean;
      
      public function WardrobeSlot(param1:class_1741, param2:HabboAvatarEditor, param3:int, param4:Boolean, param5:String = null, param6:String = null)
      {
         super();
         var_55 = param2;
         var_2895 = param3;
         createView(param1);
         update(param5,param6,param4);
      }
      
      public function get id() : int
      {
         return var_2895;
      }
      
      public function update(param1:String, param2:String, param3:Boolean) : void
      {
         switch(param2)
         {
            case "M":
            case "m":
            case "M":
               param2 = "M";
               break;
            case "F":
            case "f":
            case "F":
               param2 = "F";
         }
         var_975 = param1;
         var_111 = param2;
         var_3091 = param3;
         updateView();
      }
      
      private function createView(param1:class_1741) : void
      {
         var_18 = param1.clone() as class_1812;
         var_18.procedure = eventHandler;
         var_18.visible = false;
         var_742 = var_18.findChildByName("image") as class_2251;
      }
      
      public function dispose() : void
      {
         var_55 = null;
         var_975 = null;
         var_111 = null;
         var_742 = null;
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function updateView() : void
      {
         var _loc1_:BitmapData = null;
         var _loc5_:class_1827 = null;
         var _loc9_:BitmapDataAsset = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:Boolean = true;
         var _loc6_:Boolean = var_55.manager.getBoolean("zoom.enabled");
         if(var_975 && var_3091)
         {
            _loc5_ = var_55.manager.avatarRenderManager.createAvatarImage(figure,_loc6_ ? "h" : "sh",var_111,this);
            if(_loc5_)
            {
               _loc5_.setDirection("full",4);
               _loc1_ = _loc5_.getCroppedImage("full",_loc6_ ? 0.5 : 1);
               _loc5_.dispose();
            }
         }
         else
         {
            _loc9_ = var_55.manager.windowManager.assets.getAssetByName("avatar_editor_wardrobe_empty_slot") as BitmapDataAsset;
            if(_loc9_)
            {
               _loc1_ = _loc9_.content as BitmapData;
               _loc8_ = false;
            }
         }
         if(!_loc1_)
         {
            return;
         }
         if(var_742)
         {
            if(var_742.bitmap)
            {
               var_742.bitmap.dispose();
            }
            var_742.bitmap = new BitmapData(var_742.width,var_742.height,true,0);
            _loc3_ = (var_742.width - _loc1_.width) / 2;
            _loc4_ = (var_742.height - _loc1_.height) / 2;
            var_742.bitmap.draw(_loc1_,new Matrix(1,0,0,1,_loc3_,_loc4_));
         }
         if(_loc8_)
         {
            _loc1_.dispose();
         }
         var _loc7_:class_2143 = var_18.findChildByName("set_button") as class_2143;
         if(_loc7_)
         {
            _loc7_.visible = var_3091;
         }
         var _loc2_:class_2143 = var_18.findChildByName("get_button") as class_2143;
         if(_loc2_)
         {
            _loc2_.visible = var_3091 && var_975 != null;
         }
      }
      
      private function eventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!var_55.verifyClubLevel())
         {
            return;
         }
         switch(param2.name)
         {
            case "set_button":
               var_975 = var_55.figureData.getFigureString();
               var_111 = var_55.gender;
               var_55.handler.saveWardrobeOutfit(var_2895,this);
               updateView();
               break;
            case "get_button":
            case "get_figure":
               if(var_975)
               {
                  var_55.setNftOutfit(null);
                  var_55.loadAvatarInEditor(var_975,var_111,var_55.clubMemberLevel);
               }
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
      
      public function get view() : class_1812
      {
         return var_18;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         updateView();
      }
   }
}

