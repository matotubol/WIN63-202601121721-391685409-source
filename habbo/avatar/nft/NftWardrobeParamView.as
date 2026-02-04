package com.sulake.habbo.avatar.nft
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.avatar.wardrobe.NftOutfit;
   
   public class NftWardrobeParamView implements class_13
   {
      
      private var var_36:NftAvatarsModel;
      
      private var _container:class_1812;
      
      private var var_3803:ITextWindow;
      
      public function NftWardrobeParamView(param1:NftAvatarsModel)
      {
         super();
         var_36 = param1;
         _container = param1.controller.view.collectiblesAvatarInfoContainer;
         var_3803 = _container.findChildByName("avatar_info_text") as ITextWindow;
         updateView(null);
      }
      
      public function dispose() : void
      {
         var_36 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_36 == null;
      }
      
      public function updateView(param1:NftOutfit) : void
      {
         if(param1 == null)
         {
            _container.visible = false;
         }
         else
         {
            var_3803.text = getLocalizedCollectionName(param1.contractKey) + " #" + param1.id;
            var_3803.textColor = getCollectionTextColor(param1.contractKey);
            _container.visible = true;
         }
      }
      
      private function getLocalizedCollectionName(param1:String) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case "habbo:avatar":
               _loc2_ = "wardrobe.token.avatar.name";
               break;
            case "habbo:clothes":
               _loc2_ = "wardrobe.token.clothing.name";
               break;
            case "habbo:avatar_genesis":
               _loc2_ = "wardrobe.token.crafted_avatar.name";
               break;
            default:
               return null;
         }
         return var_36.controller.manager.localization.getLocalization(_loc2_);
      }
      
      private function getCollectionTextColor(param1:String) : int
      {
         switch(param1)
         {
            case "habbo:avatar":
               return 4294936611;
            case "habbo:clothes":
               return 4289965509;
            case "habbo:avatar_genesis":
               return 4279945953;
            default:
               return 4294967295;
         }
      }
   }
}

