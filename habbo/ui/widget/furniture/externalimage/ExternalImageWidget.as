package com.sulake.habbo.ui.widget.furniture.externalimage
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.assets.loaders.BitmapFileLoader;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1899;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.inventory.items.class_1875;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.ExternalImageWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.utils.AlertDialogCaption;
   import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
   import com.sulake.room.object.IRoomObject;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import package_69.JSONDecoder;
   import package_9.class_1879;
   
   public class ExternalImageWidget extends RoomWidgetBase
   {
      
      private static const TYPE_PHOTO_POSTER:String = "photo_poster";
      
      private static const TYPE_SELFIE:String = "selfie";
      
      private static const TYPE_LEGACY:String = "legacy";
      
      private static const HORIZONTAL_ITEM_SPACING:int = 10;
      
      private static const VERTICAL_SPACE:int = 71;
      
      private var _window:class_1812;
      
      private var var_184:class_2251;
      
      private var _moderationText:class_1899;
      
      private var _makeOwnButton:class_1741;
      
      private var var_421:class_1741;
      
      private var var_2315:class_1812;
      
      private var _bgBorder:class_1741;
      
      private var _buttonContainer:class_1812;
      
      private var _shareArea:class_1812;
      
      private var _shareButton:class_1741;
      
      private var _senderNameButton:IRegionWindow;
      
      private var var_3388:ILabelWindow;
      
      private var var_1342:TextField;
      
      private var var_2579:ILabelWindow;
      
      private var var_2128:BitmapFileLoader;
      
      private var var_3041:Bitmap;
      
      private var _inventory:class_61;
      
      private var var_1686:int;
      
      private var var_1599:String;
      
      private var _caption:String;
      
      private var var_1229:int;
      
      private var var_1127:String;
      
      private var var_2967:class_1812;
      
      private var var_1235:String;
      
      private var var_5402:class_2251;
      
      private var _habboHelp:IHabboHelp;
      
      private var _roomEngine:IRoomEngine;
      
      private var reportWindow:class_1812;
      
      private var var_415:int = 0;
      
      private var var_3047:Boolean = false;
      
      private var var_59:class_17;
      
      public function ExternalImageWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27, param5:class_61, param6:IHabboHelp, param7:IRoomEngine, param8:class_17)
      {
         super(param1,param2,param3,param4);
         _window = param2.buildFromXML(param3.getAssetByName("stories_image_widget_xml").content as XML) as class_1812;
         ownHandler.widget = this;
         var_421 = _window.findChildByName("closebutton") as class_1741;
         var_184 = _window.findChildByName("imageLoader") as class_2251;
         _moderationText = _window.findChildByName("moderationText") as class_1899;
         _moderationText.addEventListener("WE_LINK",onClickModerationInfoLink);
         _shareArea = _window.findChildByName("shareArea") as class_1812;
         var_2315 = _window.findChildByName("removeButtonContainer") as class_1812;
         _makeOwnButton = _window.findChildByName("makeOwnButton") as class_1741;
         _shareButton = _window.findChildByName("shareButtonContainer") as class_1741;
         _bgBorder = _window.findChildByName("bgBorder") as class_1741;
         _senderNameButton = _window.findChildByName("senderNameButton") as IRegionWindow;
         var_3388 = _window.findChildByName("senderName") as ILabelWindow;
         var_1342 = new TextField();
         if(ownHandler.container.roomSession.roomControllerLevel == 5)
         {
            var _loc9_:class_1970 = _window.findChildByName("name_copy_wrapper") as class_1970;
            var_1342.textColor = 10061943;
            var_1342.text = "";
            null.setDisplayObject(var_1342);
         }
         var_2579 = _window.findChildByName("creationDate") as ILabelWindow;
         _buttonContainer = _window.findChildByName("buttonContainer") as class_1812;
         _inventory = param5;
         _habboHelp = param6;
         _roomEngine = param7;
         var_2967 = _window.findChildByName("reportButtonContainer") as class_1812;
         _window.procedure = onWindowEvent;
         _window.center();
         _shareArea.visible = false;
         var_59 = param8;
         hide();
      }
      
      private function get ownHandler() : ExternalImageWidgetHandler
      {
         return var_41 as ExternalImageWidgetHandler;
      }
      
      public function showWithRoomObject(param1:IRoomObject) : void
      {
         var_1686 = param1.getId();
         var_1235 = param1.getType();
         var_3047 = false;
         var_2315.visible = ownHandler.hasRightsToRemove();
         if(getType() == "photo_poster")
         {
            var_2967.visible = true;
         }
         else
         {
            var_2967.visible = ownHandler.isSelfieReportingEnabled();
         }
         show(param1.getModel().getString("furniture_data"));
         var _loc2_:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
         if(_loc2_.indexOf(param1) != -1)
         {
            var_415 = _loc2_.indexOf(param1);
         }
      }
      
      public function showWithFurniID(param1:int) : void
      {
         var _loc2_:class_1875 = _inventory.getWallItemById(param1);
         if(_loc2_)
         {
            var_1686 = param1;
            var_1235 = _roomEngine.getWallItemType(_loc2_.type);
            var_3047 = true;
            var_2315.visible = false;
            var_2967.visible = false;
            show(_loc2_.stuffData.getLegacyString());
         }
      }
      
      private function show(param1:String) : void
      {
         if(ownHandler.storiesImageUrlBase == "disabled")
         {
            return;
         }
         clearImage();
         if(param1 != null)
         {
            readFurniJson(param1);
         }
      }
      
      private function showNext() : void
      {
         var _loc1_:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
         if(_loc1_.length > 0)
         {
            var_415 = var_415 + 1;
            if(var_415 > _loc1_.length - 1)
            {
               var_415 = 0;
            }
            showWithRoomObject(_loc1_[var_415]);
         }
      }
      
      private function showPrevious() : void
      {
         var _loc1_:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
         if(_loc1_.length > 0)
         {
            var_415 = var_415 - 1;
            if(var_415 < 0)
            {
               var_415 = _loc1_.length - 1;
            }
            showWithRoomObject(_loc1_[var_415]);
         }
      }
      
      private function getWallItemsOfCurrentTypeInRoom() : Vector.<IRoomObject>
      {
         var _loc2_:Vector.<IRoomObject> = new Vector.<IRoomObject>();
         var _loc3_:Array = _roomEngine.getObjectsByCategory(20);
         for each(var _loc1_ in _loc3_)
         {
            if(_loc1_.getType() == var_1235)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      private function clearImage() : void
      {
         var_1599 = null;
         _caption = "";
         var _loc1_:ITextWindow = _window.findChildByName("captionText") as ITextWindow;
         _loc1_.text = "";
         _senderNameButton.visible = false;
         var_1229 = 0;
         var_3388.caption = "";
         var_1342.text = "";
         var_2579.caption = "";
         var_1127 = null;
         _moderationText.visible = false;
         drawImage(new Bitmap(new BitmapData(var_184.width - 2,var_184.height - 2,false,0)));
      }
      
      private function readFurniJson(param1:String) : void
      {
         try
         {
            var_1599 = new JSONDecoder(param1,false).getValue().id;
            if(var_1599)
            {
               loadExternalData();
               return;
            }
            loadPhoto(param1,getImageUrl(new JSONDecoder(param1,false).getValue()));
         }
         catch(error:Error)
         {
         }
      }
      
      private function getImageUrl(param1:Object) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = getJsonValue(param1,"w","url");
         if(_loc2_.indexOf("http") != 0)
         {
            _loc3_ = "postcards/selfie/";
            if(getType() == "photo_poster")
            {
               _loc3_ = "";
            }
            if(_loc2_.indexOf(".png") == -1)
            {
               _loc2_ += ".png";
            }
            _loc2_ = ownHandler.storiesImageUrlBase + _loc3_ + _loc2_;
         }
         return _loc2_;
      }
      
      private function loadPhoto(param1:String, param2:String) : void
      {
         var _loc8_:Object = null;
         try
         {
            _loc8_ = new JSONDecoder(param1,false).getValue();
         }
         catch(error:Error)
         {
            return;
         }
         if(!param2)
         {
            param2 = getImageUrl(_loc8_);
         }
         var_2128 = new BitmapFileLoader("image/png",new URLRequest(param2));
         var_2128.addEventListener("AssetLoaderEventComplete",onImageLoaded);
         var _loc4_:String = getJsonValue(_loc8_,"n","creator_name");
         var _loc5_:String = getJsonValue(_loc8_,"s","creator_id");
         var _loc11_:String = getJsonValue(_loc8_,"u","unique_id");
         var _loc6_:String = getJsonValue(_loc8_,"t","time");
         var _loc9_:Date = new Date(Number(_loc6_));
         if(_loc4_)
         {
            var_3388.caption = _loc4_;
            _senderNameButton.visible = true;
            var_1342.text = _loc4_;
            var_1229 = int(_loc5_);
            var_2579.caption = _loc9_.date + "-" + (_loc9_.month + 1) + "-" + _loc9_.fullYear;
         }
         if(ownHandler.storiesImageShareUrl && ownHandler.storiesImageShareUrl.length > 4)
         {
            var _loc3_:class_1741 = _window.findChildByName("urlField") as class_1741;
            var _loc10_:String = ownHandler.storiesImageShareUrl.replace("%id%",_loc11_);
            null.caption = null;
            var_1127 = null;
         }
         _caption = getJsonValue(_loc8_,"m","caption");
         if(_caption)
         {
            var _loc7_:ITextWindow = _window.findChildByName("captionText") as ITextWindow;
            _loc7_.text = _caption;
         }
      }
      
      private function getJsonValue(param1:Object, param2:String, param3:String = null) : String
      {
         var _loc4_:String = null;
         _loc4_ = param1[param2];
         if(!_loc4_ && param3)
         {
            _loc4_ = param1[param3];
         }
         return _loc4_;
      }
      
      private function onImageLoaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:Bitmap = null;
         if(var_2128)
         {
            _loc2_ = var_2128.content as Bitmap;
            if(_loc2_)
            {
               var_184.width = _loc2_.width + 2;
               var_184.height = _loc2_.height + 2;
               drawImage(_loc2_);
            }
         }
      }
      
      private function drawImage(param1:Bitmap) : void
      {
         var_3041 = param1;
         var_184.bitmap = new BitmapData(var_184.width,var_184.height,true,0);
         _window.visible = true;
         var _loc3_:class_1741 = _window.findChildByName("previousButton");
         var _loc2_:class_1741 = _window.findChildByName("nextButton");
         _loc3_.x = 10;
         _bgBorder.y = _bgBorder.x = 0;
         var_184.x = 10 * 2 + _loc3_.width;
         var_184.y = 71;
         _bgBorder.height = _window.height = var_184.height + 71 * 2;
         _bgBorder.width = _window.width = var_184.width + 10 * 4 + _loc3_.width * 2;
         _senderNameButton.x = var_184.right - _senderNameButton.width - 3;
         _senderNameButton.y = var_184.bottom + 3;
         var_2579.x = var_184.x + 3;
         var_2579.y = _senderNameButton.y = var_184.bottom;
         _buttonContainer.y = 0;
         _buttonContainer.x = _bgBorder.right - _buttonContainer.width;
         _loc2_.x = var_184.right + 10;
         if(var_3047)
         {
            _loc2_.visible = _loc3_.visible = false;
         }
         else
         {
            _loc2_.visible = _loc3_.visible = getWallItemsOfCurrentTypeInRoom().length > 1;
         }
         var _loc4_:Matrix = new Matrix();
         var _loc5_:ColorTransform = new ColorTransform();
         _loc5_.color = 0;
         _loc4_.ty += 1;
         var_184.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.tx += 1;
         _loc4_.ty -= 1;
         var_184.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.ty += 2;
         var_184.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.ty -= 1;
         _loc4_.tx += 1;
         var_184.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.tx -= 1;
         var_184.bitmap.draw(param1,_loc4_);
         _window.activate();
         updateWindowPosition();
      }
      
      private function loadExternalData() : void
      {
         var _loc2_:String = ownHandler.extraDataServiceUrl + var_1599;
         var _loc1_:URLLoader = new URLLoader(new URLRequest(_loc2_));
         _loc1_.addEventListener("httpStatus",onExternalDataHttpStatus);
         _loc1_.addEventListener("complete",onExternalDataLoaded);
         _loc1_.addEventListener("ioError",onExternalDataError);
      }
      
      private function onExternalDataHttpStatus(param1:HTTPStatusEvent) : void
      {
         if(param1.status == 403 && ownHandler.hasRightsToRemove())
         {
            _moderationText.visible = true;
         }
      }
      
      private function onExternalDataError(param1:Event) : void
      {
         if(!_moderationText.visible)
         {
            class_21.log("Extra data loading failed: " + param1.toString());
         }
      }
      
      private function onExternalDataLoaded(param1:Event) : void
      {
         var _loc2_:String = URLLoader(param1.target).data;
         if(_loc2_.length == 0)
         {
            return;
         }
         loadPhoto(_loc2_,null);
      }
      
      override public function dispose() : void
      {
         if(!_window)
         {
            return;
         }
         var_184 = null;
         var_421 = null;
         _bgBorder = null;
         _makeOwnButton = null;
         var_2315 = null;
         var_2128 = null;
         _inventory = null;
         _habboHelp = null;
         _roomEngine = null;
         var_1229 = 0;
         _senderNameButton = null;
         var_1342 = null;
         _buttonContainer = null;
         _shareArea = null;
         _window.procedure = null;
         _window.dispose();
         var_59 = null;
         super.dispose();
         if(reportWindow)
         {
            reportWindow.destroy();
         }
      }
      
      public function hide() : void
      {
         _window.visible = false;
      }
      
      private function updateWindowPosition() : void
      {
         if(!var_3041)
         {
            _window.center();
            return;
         }
         var _loc5_:Stage = var_59.context.displayObjectContainer.stage;
         var _loc1_:Number = (_loc5_.stageWidth - 100) / var_3041.width;
         var _loc3_:Number = (_loc5_.stageHeight - 200) / var_3041.height;
         if(_loc1_ < 1)
         {
            _window.x = 50;
         }
         else
         {
            _window.x = (_loc5_.stageWidth - _window.width) * 0.5;
         }
         if(_loc3_ < 1)
         {
            _window.y = 50;
         }
         else
         {
            _window.y = (_loc5_.stageHeight - _window.height) * 0.5;
         }
         var _loc4_:class_1741 = _window.findChildByName("previousButton");
         var _loc2_:class_1741 = _window.findChildByName("nextButton");
         var _loc6_:int = var_59.context.displayObjectContainer.stage.stageHeight;
         if(_bgBorder.height > _loc6_)
         {
            _loc4_.y = _loc2_.y = _loc6_ / 2 - _loc4_.height / 2;
         }
         else
         {
            _loc4_.y = _loc2_.y = _bgBorder.height / 2 - _loc4_.height / 2;
         }
      }
      
      private function onWindowEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param2 == _window)
         {
            var _loc6_:* = param1.type;
            if("WE_PARENT_RESIZED" === _loc6_)
            {
               updateWindowPosition();
            }
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "closebutton":
               hide();
               break;
            case "removebutton":
               var _loc3_:class_2001 = windowManager.confirm(var_167.getLocalization("inventory.remove.external_image_wallitem_header"),var_167.getLocalization("inventory.remove.external_image_wallitem_body"),0,onDeleteConfirm);
               null.setButtonCaption(16,new AlertDialogCaption(var_167.getLocalization("inventory.remove.external_image_wallitem_delete"),"",true));
               break;
            case "makeOwnButton":
               if(getType() == "photo_poster")
               {
                  var _loc4_:HabboToolbarEvent = new HabboToolbarEvent("HTE_ICON_CAMERA");
                  _loc4_.iconName = "imageWidgetMakeOwn";
                  ownHandler.container.toolbar.events.dispatchEvent(null);
                  hide();
                  break;
               }
               if(var_59.getInteger("spaweb",0) == 1)
               {
                  HabboWebTools.openPage("/stories/cards/selfie/edit");
                  break;
               }
               var_59.context.createLinkEvent("games/play/elisa_habbo_stories?ref=btn_selfie_myo");
               break;
            case "shareButton":
               _shareArea.visible = true;
               HabboTracking.getInstance().trackEventLog("Stories","shareopened","stories.share.clicked",var_1235);
               break;
            case "twitterShare":
               navigateToURL(new URLRequest("http://www.twitter.com/share?url=" + var_1127),"_blank");
               HabboTracking.getInstance().trackEventLog("Stories","twitter","stories.share.clicked",var_1235);
               break;
            case "fbShare":
               navigateToURL(new URLRequest("https://www.facebook.com/sharer/sharer.php?u=" + var_1127),"_blank");
               HabboTracking.getInstance().trackEventLog("Stories","facebook","stories.share.clicked",var_1235);
               break;
            case "senderNameButton":
               ownHandler.sendMessage(new class_1879(var_1229));
               break;
            case "urlField":
               var _loc5_:ITextFieldWindow = _window.findChildByName("urlField") as ITextFieldWindow;
               _loc5_.setSelection(0,null.length);
               HabboTracking.getInstance().trackEventLog("Stories","fieldselected","stories.share.clicked",var_1235);
               break;
            case "reportButton":
               openReportImage();
               break;
            case "nextButton":
               showNext();
               break;
            case "previousButton":
               showPrevious();
         }
      }
      
      private function onClickModerationInfoLink(param1:WindowLinkEvent) : void
      {
         if(param1 != null && !StringUtil.isBlank(param1.link))
         {
            navigateToURL(new URLRequest(param1.link),"_blank");
         }
      }
      
      private function openReportImage() : void
      {
         _habboHelp.startPhotoReportingInNewCfhFlow(var_1229,var_3388.caption,var_1599,var_1686);
      }
      
      private function getType() : String
      {
         switch(var_1235)
         {
            case "external_image_wallitem_poster":
            case "external_image_wallitem_poster_small":
               return "photo_poster";
            case "external_image_wallitem":
               return "selfie";
            default:
               return "legacy";
         }
      }
      
      private function onReportWindowEvent(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               reportWindow.destroy();
               break;
            case "report_confirm":
               var _loc3_:int = 0;
               var _loc9_:class_1741 = reportWindow.findChildByName("reporting_reason");
               if(_loc9_ != null)
               {
                  var _loc8_:ISelectableWindow = ISelectorWindow(null).getSelected();
                  if(_loc8_ != null)
                  {
                     _loc3_ = int(null.name);
                  }
               }
               var _loc6_:String = null;
               var _loc4_:class_1741 = reportWindow.findChildByName("input_widget");
               if(_loc4_ != null)
               {
                  var _loc7_:IIlluminaInputWidget = (null as class_2010).widget as IIlluminaInputWidget;
                  _loc6_ = _loc7_.message;
               }
               if(!var_1127)
               {
                  var_1127 = "url not available";
               }
               if(getType() == "photo_poster")
               {
                  var _loc5_:Boolean = _habboHelp.reportPhoto(var_1599,0,_roomEngine.activeRoomId,var_1229,var_1686);
                  break;
               }
               _loc5_ = _habboHelp.reportSelfie(var_1127,null,_roomEngine.activeRoomId,var_1229,var_1686);
         }
      }
      
      private function onDeleteConfirm(param1:class_2001, param2:class_1758) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            ownHandler.deleteCard(var_1686);
         }
      }
      
      override public function release() : void
      {
         hide();
         super.release();
      }
   }
}

