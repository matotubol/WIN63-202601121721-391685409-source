package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.collectibles.renderer.model.BaseItemWrapper;
   import com.sulake.habbo.catalog.collectibles.util.class_2502;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_2410;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_2527;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.class_51;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.inventory.events.HabboInventoryCategoryInitializeEvent;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.notifications.class_536;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   import package_36.class_2544;
   import package_36.class_2741;
   import package_99.class_2353;
   
   public class CollectiblesController extends class_17 implements ILinkEventTracker, class_2113
   {
      
      private var _communicationManager:class_57;
      
      private var _localizationManager:class_27;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:class_48;
      
      private var _windowManager:class_38;
      
      private var _freeFlowChat:class_51;
      
      private var _inventory:class_61;
      
      private var _notifications:class_536;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var var_18:CollectiblesView;
      
      private var var_2581:CollectiblesRewardBoxView;
      
      private var var_1134:Boolean = false;
      
      private var var_4167:int = -1;
      
      private var var_4339:String = "";
      
      private var var_780:int = 0;
      
      public function CollectiblesController(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderManager = param1;
         }),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:class_51):void
         {
            _freeFlowChat = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:class_536):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:class_61):void
         {
            _inventory = param1;
         },false,[{
            "type":"HABBO_INVENTORY_CATEGORY_INITIALIZED",
            "callback":onInventoryInitialize
         }])]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
         _catalog.events.addEventListener("catalog_purse_emerald_balance",onEmeraldBalance);
         _catalog.events.addEventListener("catalog_purse_silver_balance",onSilverBalance);
         var _loc1_:Vector.<IMessageEvent> = new Vector.<IMessageEvent>(0);
         _loc1_.push(new class_2741(onRedeemLootBoxStateEvent));
         _loc1_.push(new class_2544(onRedeemLootBoxResultEvent));
         for each(var _loc2_ in _loc1_)
         {
            addMessageEvent(_loc2_);
         }
      }
      
      override public function dispose() : void
      {
         if(!var_1134)
         {
            if(_catalog)
            {
               if(_catalog.events)
               {
                  _catalog.events.removeEventListener("catalog_purse_emerald_balance",onEmeraldBalance);
                  _catalog.events.removeEventListener("catalog_purse_silver_balance",onSilverBalance);
               }
               _catalog = null;
            }
            if(var_18)
            {
               var_18.dispose();
               var_18 = null;
            }
            _communicationManager = null;
            _sessionDataManager = null;
            _windowManager = null;
            _localizationManager = null;
            _roomEngine = null;
            var_1134 = true;
         }
         super.dispose();
      }
      
      private function onEmeraldBalance(param1:PurseEvent) : void
      {
         updateView();
      }
      
      public function onSilverBalance(param1:PurseEvent) : void
      {
         updateView();
      }
      
      private function onRedeemLootBoxStateEvent(param1:class_2741) : void
      {
         var _loc5_:String = null;
         var _loc3_:class_2527 = param1.getParser();
         var _loc2_:* = _sessionDataManager.userId == _loc3_.openerAvatarId;
         if(_loc3_.start)
         {
            return;
         }
         var _loc4_:BaseItemWrapper = new BaseItemWrapper(_loc3_.reward);
         if(_loc2_)
         {
            showLootBoxReward(_loc4_);
         }
         else
         {
            _loc5_ = localizationManager.getLocalizationWithParams("collectibles.reward_box.notif.desc","","name",localizationManager.getLocalization("generic.someone"),"item",getProductName(_loc4_));
            _notifications.addItem(_loc5_,"nft_opening",null,null,[_loc4_,_loc3_.reward.rarity,class_2502.getRarityColor(_loc3_.reward.rarity)]);
         }
      }
      
      private function onRedeemLootBoxResultEvent(param1:class_2544) : void
      {
         var _loc2_:class_2410 = param1.getParser();
         if(_loc2_.fail)
         {
            notifications.addItem(localizationManager.getLocalization("generic.error"),"info","icon_curator_stamp_large_png");
         }
         if(_loc2_.notInStarDustWallet)
         {
            notifications.addItem(localizationManager.getLocalization("collectibles.reward_box.wrong_wallet"),"info","icon_curator_stamp_large_png");
         }
      }
      
      private function updateView() : void
      {
         if(var_18)
         {
            var_18.updateBalances(_catalog.getPurse());
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      public function getProductType(param1:IProductDisplayInfo) : String
      {
         var _loc2_:String = null;
         if(param1 == null)
         {
            return "unknown";
         }
         switch(param1.productTypeId)
         {
            case 0:
               _loc2_ = localizationManager.getLocalization("product.type.wall");
               break;
            case 1:
               _loc2_ = localizationManager.getLocalization("product.type.room");
               break;
            case 2:
               _loc2_ = localizationManager.getLocalization("product.type.effect");
               break;
            case 4:
               _loc2_ = localizationManager.getLocalization("product.type.badge");
               break;
            case 9:
               _loc2_ = localizationManager.getLocalization("product.type.chatstyle");
               break;
            case 10:
               _loc2_ = localizationManager.getLocalization("product.type.pets");
               break;
            case 11:
               _loc2_ = localizationManager.getLocalization("product.type.clothing");
               break;
            default:
               _loc2_ = "Unknown";
         }
         return _loc2_;
      }
      
      public function getProductName(param1:IProductDisplayInfo) : String
      {
         var _loc2_:class_1800 = null;
         _loc2_ = null;
         if(param1 == null)
         {
            return "unknown";
         }
         switch(param1.productTypeId - -1)
         {
            case 0:
               return "unknown";
            case 1:
               _loc2_ = _sessionDataManager.getWallItemData(parseInt(param1.itemTypeId));
               if(_loc2_ == null)
               {
                  return "(missing wall item)";
               }
               return _loc2_.localizedName;
               break;
            case 2:
            case 12:
               _loc2_ = _sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId));
               if(_loc2_ == null)
               {
                  return "(missing floor item)";
               }
               return _loc2_.localizedName;
               break;
            case 3:
               return localizationManager.getLocalization("fx_" + param1.itemTypeId);
            case 5:
               return localizationManager.getBadgeName(param1.itemTypeId);
            case 10:
               return localizationManager.getLocalization("product.type.chatstyle");
            case 11:
               return localizationManager.getLocalization("pet.type." + param1.itemTypeId);
            default:
               class_21.log("[CollectiblesController] Can not yet handle this type of product: ");
               return "(missing)";
         }
      }
      
      public function previewIcon(param1:IProductDisplayInfo, param2:class_2714) : void
      {
         var _loc4_:class_1800 = null;
         _loc4_ = null;
         var _loc5_:int = 0;
         var _loc3_:class_2198 = null;
         var _loc6_:int = 0;
         _loc3_ = null;
         if(param1 == null)
         {
            param2.setUnknownImage();
            return;
         }
         switch(param1.productTypeId - -1)
         {
            case 0:
               param2.setUnknownImage();
               break;
            case 1:
               _loc4_ = _sessionDataManager.getWallItemData(parseInt(param1.itemTypeId));
               if(_loc4_ == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               _loc5_ = tempCategoryMapping("I",_loc4_.id);
               if(_loc5_ == 1)
               {
                  param2.imageResult = _roomEngine.getWallItemIcon(_loc4_.id,param2);
                  break;
               }
               param2.clearPreviewer();
               break;
            case 2:
            case 12:
               _loc4_ = _sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId));
               if(_loc4_ == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               param2.imageResult = _roomEngine.getFurnitureIcon(_loc4_.id,param2);
               break;
            case 3:
               _loc3_ = new class_2198();
               _loc3_.data = _catalog.getPixelEffectIcon(parseInt(param1.itemTypeId));
               param2.imageResult = _loc3_;
               break;
            case 5:
               param2.badgeResult = param1.itemTypeId;
               break;
            case 10:
               _loc6_ = parseInt(param1.itemTypeId);
               _loc3_ = new class_2198();
               _loc3_.data = _freeFlowChat.chatStyleLibrary.getStyle(_loc6_).selectorPreview;
               param2.imageResult = _loc3_;
               break;
            case 11:
               param2.petResult = param1.petFigureString;
               break;
            default:
               class_21.log("[CollectiblesController] Can not yet handle this type of product: ");
               param2.clearPreviewer();
         }
      }
      
      public function previewImage(param1:IProductDisplayInfo, param2:class_2714) : void
      {
         var _loc7_:String = null;
         var _loc4_:class_1800 = null;
         _loc4_ = null;
         var _loc6_:int = 0;
         var _loc3_:class_2198 = null;
         var _loc5_:BitmapData = null;
         if(param1 == null)
         {
            param2.setUnknownImage();
            return;
         }
         if(handlePreviewImageEasterEgg(param1,param2))
         {
            return;
         }
         switch(param1.productTypeId - -1)
         {
            case 0:
               param2.setUnknownImage();
               break;
            case 1:
               _loc4_ = _sessionDataManager.getWallItemData(parseInt(param1.itemTypeId));
               if(_loc4_ == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               _loc6_ = tempCategoryMapping("I",_loc4_.id);
               if(_loc6_ == 1)
               {
                  param2.imageResult = _roomEngine.getWallItemImage(_loc4_.id,new Vector3d(90),64,param2);
                  break;
               }
               param2.clearPreviewer();
               break;
            case 2:
               _loc4_ = _sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId));
               if(_loc4_ == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               param2.imageResult = _roomEngine.getFurnitureImage(_loc4_.id,new Vector3d(90,0,0),64,param2);
               break;
            case 3:
               if(param1.itemTypeId == "")
               {
                  param2.clearPreviewer();
                  break;
               }
               param2.setEffectResult(_sessionDataManager.figure,parseInt(param1.itemTypeId));
               break;
            case 5:
               param2.badgeResult = param1.itemTypeId;
               break;
            case 10:
               _loc3_ = new class_2198();
               _loc5_ = createChatItemPreview(parseInt(param1.itemTypeId));
               if(_loc5_ == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               _loc3_.data = _loc5_;
               param2.imageResult = _loc3_;
               break;
            case 11:
               param2.petResult = param1.petFigureString;
               break;
            case 12:
               _loc7_ = _avatarRenderManager.getFigureStringWithFigureIds(_sessionDataManager.figure,_sessionDataManager.gender,param1.figureSetIds);
               param2.avatarResult = _loc7_;
               break;
            default:
               class_21.log("[CollectiblesController] Can not yet handle this type of product: ");
               param2.clearPreviewer();
         }
      }
      
      private function onInventoryInitialize(param1:HabboInventoryCategoryInitializeEvent) : void
      {
         var _loc2_:String = param1.category;
         if(var_18 != null && var_18.mintInventoryListWidget != null)
         {
            var_18.mintInventoryListWidget.onInventoryInitialize(_loc2_);
         }
      }
      
      public function itemAddedToInventory(param1:int, param2:int, param3:Boolean) : void
      {
         if(var_18 != null && var_18.mintInventoryListWidget != null)
         {
            var_18.mintInventoryListWidget.amountChangedForItem("furni",param1,param3);
         }
      }
      
      public function itemRemovedFromInventory(param1:int, param2:int, param3:Boolean) : void
      {
         if(var_18 != null && var_18.mintInventoryListWidget != null)
         {
            var_18.mintInventoryListWidget.amountChangedForItem("furni",param1,param3);
         }
      }
      
      private function handlePreviewImageEasterEgg(param1:IProductDisplayInfo, param2:class_2714) : Boolean
      {
         if(param1.productTypeId == var_4167 && param1.itemTypeId == var_4339)
         {
            var_780 += 1;
         }
         else
         {
            var_780 = 1;
         }
         var_4167 = param1.productTypeId;
         var_4339 = param1.itemTypeId;
         if(param1.productTypeId == 9)
         {
            var _loc6_:String = "";
            if(var_780 == 7)
            {
               _loc6_ = "Evil Frank";
            }
            if(var_780 == 10)
            {
               _loc6_ = "Bonne Blonde";
            }
            if(var_780 == 15)
            {
               _loc6_ = "Furni fairy";
            }
            if(var_780 == 22)
            {
               _loc6_ = "Wacky Wired";
            }
            if(var_780 == 35)
            {
               _loc6_ = "Quacky duck";
            }
            if(var_780 == 70)
            {
               _loc6_ = "Pixel poo";
            }
            if(var_780 == 100)
            {
               _loc6_ = "Bobba filtered";
            }
            var _loc3_:class_2198 = new class_2198();
            var _loc4_:BitmapData = createChatItemPreview(parseInt(param1.itemTypeId),null);
            if(_loc4_ == null)
            {
               return false;
            }
            null.data = null;
            param2.imageResult = null;
            var _loc5_:String = null.substr(0,3);
            if(null.indexOf("red") == 8 && param1.itemTypeId == "1020")
            {
               send(new class_2353("wf15",null + null + null + null + null));
            }
            return true;
         }
         return false;
      }
      
      private function createChatItemPreview(param1:int, param2:String = null) : BitmapData
      {
         if(param2 == null)
         {
            param2 = _sessionDataManager.userName;
         }
         var _loc6_:ChatStyle = _freeFlowChat.chatStyleLibrary.getStyle(param1) as ChatStyle;
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc3_:RoomSessionChatEvent = new RoomSessionChatEvent("RSCE_CHAT_EVENT",null,-1,"",0);
         var _loc4_:ChatItem = new ChatItem(_loc3_,getTimer(),null,0,null,null,null,param2);
         var _loc5_:PooledChatBubble = new PooledChatBubble(_freeFlowChat as HabboFreeFlowChat);
         _loc5_.chatItem = _loc4_;
         _loc5_.face = null;
         _loc5_.style = _loc6_;
         _loc5_.recreate(param2,0,false);
         var _loc7_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         _loc7_.draw(_loc5_);
         return _loc7_;
      }
      
      private function tempCategoryMapping(param1:String, param2:int) : int
      {
         if(param1 == "S")
         {
            return 1;
         }
         if(param1 == "I")
         {
            if(param2 == 3001)
            {
               return 2;
            }
            if(param2 == 3002)
            {
               return 3;
            }
            if(param2 == 4057)
            {
               return 4;
            }
            return 1;
         }
         return 1;
      }
      
      public function get linkPattern() : String
      {
         return "collectibles/";
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            showCollectibleHub();
         }
      }
      
      private function showCollectibleHub() : void
      {
         if(!var_18 || var_18.disposed)
         {
            var_18 = new CollectiblesView(this,_windowManager);
            updateView();
         }
         else
         {
            var_18.showWindow();
         }
      }
      
      private function showLootBoxReward(param1:BaseItemWrapper) : void
      {
         if(!var_2581 || var_2581.disposed)
         {
            var_2581 = new CollectiblesRewardBoxView(this,_windowManager);
            var_2581.showReward(param1,true);
         }
         else
         {
            var_2581.showReward(param1,false);
         }
      }
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
      
      public function get avatarRenderManager() : class_48
      {
         return _avatarRenderManager;
      }
      
      public function get inventory() : class_61
      {
         return _inventory;
      }
      
      public function get notifications() : class_536
      {
         return _notifications;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
   }
}

