package com.sulake.habbo.ui.widget.furniture.mannequin
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_1900;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.MannequinWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import package_55.class_2945;
   import package_94.class_3268;
   import package_94.class_3456;
   
   public class MannequinWidget extends RoomWidgetBase
   {
      
      private static const CONTENT_CONTROLLER_MAIN:int = 0;
      
      private static const CONTENT_CONTROLLER_UPDATE:int = 1;
      
      private static const CONTENT_PEER_MAIN:int = 2;
      
      private static const CONTENT_NO_CLUB:int = 3;
      
      private static const CONTENT_WRONG_GENDER:int = 4;
      
      private static const const_202:String = "header_button_close";
      
      private static const const_248:String = "save_button";
      
      private static const const_516:String = "wear_button";
      
      private static const const_383:String = "configure_button";
      
      private static const const_1036:String = "get_club_button";
      
      private static const const_207:String = "cancel_text";
      
      private static const const_1021:String = "back_region";
      
      private static const const_147:String = "ok_button";
      
      private static const ELEM_OUTFIT_NAME_SET:String = "outfit_name_set";
      
      private static const const_152:String = "outfit_name_show";
      
      private static const NAME_STATE_HINT:int = 0;
      
      private static const NAME_STATE_WRITING:int = 1;
      
      private static const NAME_STATE_SAVED:int = 2;
      
      private static const NAME_TEXT_COLOR_SAVED:uint = 0;
      
      private static const NAME_TEXT_COLOR_WRITING:uint = 8956552;
      
      private static const NAME_TEXT_COLOR_HINT:uint = 7829367;
      
      private static const ICON_STYLE_CLUB:int = 13;
      
      private static const ICON_STYLE_VIP:int = 14;
      
      private static const MANNEQUIN_CLOTHING_PART_TYPES:Array = new Array("ca","cc","ch","lg","sh","wa");
      
      private static const MANNEQUIN_FIGURE:Array = ["hd",99999,[99998]];
      
      private var _window:class_1812;
      
      private var var_2536:int;
      
      private var var_2441:String;
      
      private var var_3807:String;
      
      private var var_1710:int;
      
      private var _savedOutfitName:String;
      
      private var var_3265:int = -1;
      
      public function MannequinWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27)
      {
         super(param1,param2,param3,param4);
         this.handler.widget = this;
      }
      
      public function get handler() : MannequinWidgetHandler
      {
         return var_41 as MannequinWidgetHandler;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         super.dispose();
      }
      
      public function open(param1:int, param2:String, param3:String, param4:String) : void
      {
         var_2536 = param1;
         var_2441 = param2;
         var_3807 = param3;
         _savedOutfitName = param4;
         var _loc10_:IRoomSession = (var_41 as MannequinWidgetHandler).container.roomSession;
         var _loc6_:ISessionDataManager = (var_41 as MannequinWidgetHandler).container.sessionDataManager;
         var _loc11_:Boolean = _loc10_.isRoomOwner || _loc10_.roomControllerLevel >= 1 || _loc6_.isAnyRoomController;
         var _loc8_:class_48 = (var_41 as MannequinWidgetHandler).container.avatarRenderManager;
         var _loc9_:class_1900 = _loc8_.createFigureContainer(param2);
         var_1710 = _loc8_.resolveClubLevel(_loc9_,var_3807,MANNEQUIN_CLOTHING_PART_TYPES);
         var _loc7_:int = resolveFirstWindowContent(_loc11_,_loc6_.gender,_loc6_.clubLevel,param3,var_1710);
         setWindowContent(_loc7_);
         var _loc5_:int = _savedOutfitName && _savedOutfitName != "" ? 2 : 0;
         setOutfitNameState(_loc5_);
         _window.visible = true;
      }
      
      private function resolveFirstWindowContent(param1:Boolean, param2:String, param3:int, param4:String, param5:int) : int
      {
         if(param1)
         {
            return 0;
         }
         if(param2.toLowerCase() != param4.toLowerCase())
         {
            return 4;
         }
         if(param3 < param5)
         {
            return 3;
         }
         return 2;
      }
      
      private function setWindowContent(param1:int) : void
      {
         var _loc7_:BitmapData = null;
         var _loc6_:class_1900 = null;
         var _loc3_:ISessionDataManager = (var_41 as MannequinWidgetHandler).container.sessionDataManager;
         var _loc4_:String = _loc3_.figure;
         var _loc5_:class_48 = (var_41 as MannequinWidgetHandler).container.avatarRenderManager;
         var _loc2_:int = _savedOutfitName && _savedOutfitName != "" ? 2 : 0;
         if(!_window)
         {
            _window = windowManager.buildFromXML(assets.getAssetByName("mannequin_widget_frame_xml").content as XML) as class_1812;
            addClickListener("header_button_close");
            _window.center();
         }
         (_window as class_2250).content.removeChildAt(0);
         var _loc8_:class_1812 = createWindow(param1);
         (_window as class_2250).content.addChild(_loc8_);
         switch(param1)
         {
            case 0:
               addClickListener("configure_button");
               addClickListener("wear_button");
               addTextFieldListener("outfit_name_set");
               addClickListener("outfit_name_set");
               _loc6_ = _loc5_.createFigureContainer(var_2441);
               transformAsMannequinFigure(_loc6_);
               _loc7_ = createAvatarImage(_loc6_.getFigureString());
               updateClubLevelView(var_1710);
               setOutfitNameState(_loc2_);
               updateDecorations();
               break;
            case 1:
               addClickListener("save_button");
               addClickListener("back_region");
               _loc6_ = _loc5_.createFigureContainer(_loc4_);
               transformAsMannequinFigure(_loc6_);
               _loc7_ = createAvatarImage(_loc6_.getFigureString());
               updateClubLevelView(_loc5_.resolveClubLevel(_loc6_,_loc3_.gender,MANNEQUIN_CLOTHING_PART_TYPES));
               setOutfitNameState(_loc2_);
               break;
            case 2:
               addClickListener("wear_button");
               _loc6_ = applyMannequinOutfit(_loc4_,var_2441);
               _loc7_ = createAvatarImage(_loc6_.getFigureString());
               updateClubLevelView(var_1710);
               setOutfitNameState(_loc2_);
               break;
            case 3:
               addClickListener("get_club_button");
               _loc6_ = applyMannequinOutfit(_loc4_,var_2441);
               _loc7_ = createAvatarImage(_loc6_.getFigureString());
               updateClubLevelView(var_1710);
               break;
            case 4:
               addClickListener("ok_button");
               _loc6_ = _loc5_.createFigureContainer(var_2441);
               transformAsMannequinFigure(_loc6_);
               _loc7_ = createAvatarImage(_loc6_.getFigureString());
               updateClubLevelView(var_1710);
               break;
            default:
               throw new Error("Invalid type for mannequin widget content apply: " + param1);
         }
         updatePreviewImage(_loc8_,_loc7_);
      }
      
      private function createWindow(param1:int) : class_1812
      {
         var _loc3_:* = null;
         var _loc2_:IAsset = null;
         switch(param1)
         {
            case 0:
               _loc2_ = _assets.getAssetByName("mannequin_controller_main_xml");
               break;
            case 1:
               _loc2_ = _assets.getAssetByName("mannequin_controller_save_xml");
               break;
            case 2:
               _loc2_ = _assets.getAssetByName("mannequin_peer_main_xml");
               break;
            case 3:
               _loc2_ = _assets.getAssetByName("mannequin_no_club_xml");
               break;
            case 4:
               _loc2_ = _assets.getAssetByName("mannequin_wrong_gender_xml");
               break;
            default:
               throw new Error("Invalid type for mannequin widget content creation: " + param1);
         }
         return (var_41 as MannequinWidgetHandler).container.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
      }
      
      private function transformAsMannequinFigure(param1:class_1900) : void
      {
         for each(var _loc2_ in param1.getPartTypeIds())
         {
            if(MANNEQUIN_CLOTHING_PART_TYPES.indexOf(_loc2_) == -1)
            {
               param1.removePart(_loc2_);
            }
         }
         param1.updatePart(MANNEQUIN_FIGURE[0],MANNEQUIN_FIGURE[1],MANNEQUIN_FIGURE[2]);
      }
      
      private function createAvatarImage(param1:String) : BitmapData
      {
         var _loc3_:class_48 = (var_41 as MannequinWidgetHandler).container.avatarRenderManager;
         var _loc4_:class_1827 = _loc3_.createAvatarImage(param1,"h");
         var _loc2_:BitmapData = _loc4_.getCroppedImage("full");
         _loc4_.dispose();
         return _loc2_;
      }
      
      private function applyMannequinOutfit(param1:String, param2:String) : class_1900
      {
         var _loc5_:* = null;
         var _loc4_:class_48 = (var_41 as MannequinWidgetHandler).container.avatarRenderManager;
         var _loc3_:class_1900 = _loc4_.createFigureContainer(param1);
         var _loc6_:class_1900 = _loc4_.createFigureContainer(param2);
         for each(_loc5_ in MANNEQUIN_CLOTHING_PART_TYPES)
         {
            _loc3_.removePart(_loc5_);
         }
         for each(_loc5_ in _loc6_.getPartTypeIds())
         {
            _loc3_.updatePart(_loc5_,_loc6_.getPartSetId(_loc5_),_loc6_.getPartColorIds(_loc5_));
         }
         return _loc3_;
      }
      
      private function updateClubLevelView(param1:int) : void
      {
         var _loc2_:IIconWindow = _window.findChildByName("club_icon") as IIconWindow;
         if(!_loc2_)
         {
            return;
         }
         switch(param1)
         {
            case 0:
               _loc2_.visible = false;
               break;
            case 1:
               _loc2_.style = 13;
               _loc2_.visible = true;
               break;
            case 2:
               _loc2_.style = 14;
               _loc2_.visible = true;
         }
      }
      
      private function updatePreviewImage(param1:class_1812, param2:BitmapData) : void
      {
         var _loc5_:BitmapData = null;
         if(!param1 || !param2)
         {
            return;
         }
         var _loc6_:class_2251 = param1.findChildByName("preview_image") as class_2251;
         if(_loc6_.bitmap == null)
         {
            _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height);
         }
         var _loc3_:IAsset = assets.getAssetByName("mannequin_preview_bg_png") as IAsset;
         if(_loc3_)
         {
            _loc5_ = _loc3_.content as BitmapData;
            _loc6_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(0,0));
         }
         var _loc4_:Point = new Point((_loc6_.width - param2.width) / 2,(_loc6_.height - param2.height) / 2);
         _loc6_.bitmap.copyPixels(param2,param2.rect,_loc4_,null,null,true);
      }
      
      private function updateDecorations() : void
      {
         var _loc1_:BitmapDataAsset = null;
         var _loc2_:class_2251 = _window.findChildByName("write_deco") as class_2251;
         if(_loc2_)
         {
            _loc1_ = _assets.getAssetByName("small_pen") as BitmapDataAsset;
            _loc2_.bitmap = _loc1_.content as BitmapData;
            _loc2_.disposesBitmap = false;
         }
      }
      
      private function close() : void
      {
         _window.visible = false;
      }
      
      private function setOutfitNameState(param1:int) : void
      {
         var_3265 = param1;
         var _loc3_:ITextWindow = _window.findChildByName("outfit_name_set") as ITextWindow;
         if(_loc3_)
         {
            switch(param1)
            {
               case 0:
                  _loc3_.text = handler.container.localization.getLocalization("mannequin.widget.set_name_hint");
                  _loc3_.textColor = 7829367;
                  _loc3_.italic = true;
                  break;
               case 1:
                  _loc3_.textColor = 8956552;
                  _loc3_.italic = false;
                  break;
               case 2:
                  _loc3_.text = _savedOutfitName;
                  _loc3_.textColor = 0;
                  _loc3_.italic = false;
                  break;
               default:
                  _loc3_.text = handler.container.localization.getLocalization("mannequin.widget.set_name_hint");
                  _loc3_.textColor = 7829367;
            }
         }
         var _loc2_:ITextWindow = _window.findChildByName("outfit_name_show") as ITextWindow;
         if(_loc2_ && _savedOutfitName && _savedOutfitName != "")
         {
            _loc2_.text = "\'" + _savedOutfitName + "\'";
         }
      }
      
      private function clearNameField() : void
      {
         var _loc1_:ITextWindow = _window.findChildByName("outfit_name_set") as ITextWindow;
         if(_loc1_)
         {
            _loc1_.text = "";
         }
      }
      
      private function saveOutfit() : void
      {
         handler.container.connection.send(new class_3268(var_2536));
      }
      
      private function saveOutfitName() : void
      {
         var _loc1_:String = getNameFromView();
         handler.container.connection.send(new class_3456(var_2536,_loc1_));
         _savedOutfitName = _loc1_;
         setOutfitNameState(2);
      }
      
      private function getNameFromView() : String
      {
         var _loc2_:String = (_window.findChildByName("outfit_name_set") as ITextWindow).text;
         var _loc1_:String = handler.container.localization.getLocalization("mannequin.widget.set_name_hint");
         return _loc2_ == _loc1_ ? "" : _loc2_;
      }
      
      private function addClickListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",onMouseClick);
      }
      
      private function addTextFieldListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WKE_KEY_UP",onKeyTyped);
      }
      
      private function onKeyTyped(param1:WindowKeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            saveOutfitName();
         }
         else if(var_3265 != 1)
         {
            setOutfitNameState(1);
         }
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:ISessionDataManager = (var_41 as MannequinWidgetHandler).container.sessionDataManager;
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_text":
            case "ok_button":
               close();
               break;
            case "save_button":
               saveOutfit();
               close();
               break;
            case "wear_button":
               if(_loc2_.clubLevel < var_1710)
               {
                  setWindowContent(3);
                  break;
               }
               if(_loc2_.gender.toLowerCase() != var_3807.toLowerCase())
               {
                  setWindowContent(4);
                  break;
               }
               handler.container.connection.send(new class_2945(var_2536));
               close();
               break;
            case "configure_button":
               saveOutfitName();
               setWindowContent(1);
               break;
            case "back_region":
               setWindowContent(0);
               break;
            case "get_club_button":
               (var_41 as MannequinWidgetHandler).container.catalog.openClubCenter();
               close();
               break;
            case "outfit_name_set":
               if(var_3265 == 0)
               {
                  clearNameField();
                  setOutfitNameState(1);
                  break;
               }
               if(var_3265 == 2)
               {
                  setOutfitNameState(1);
               }
         }
      }
   }
}

