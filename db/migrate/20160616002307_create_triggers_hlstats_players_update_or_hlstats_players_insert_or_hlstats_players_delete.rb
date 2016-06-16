# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersHlstatsPlayersUpdateOrHlstatsPlayersInsertOrHlstatsPlayersDelete < ActiveRecord::Migration
  def up
    create_trigger("hlstats_players_after_update_of_clan_hideranking_row_tr", :generated => true, :compatibility => 1).
        on("hlstats_Players").
        after(:update).
        of(:clan, :hideranking) do
      <<-SQL_ACTIONS

    BEGIN
      IF NEW.hideranking <> OLD.hideranking THEN
        IF NEW.hideranking = 0  THEN
          UPDATE hlstats_Clans SET members = members + 1 where clanId = OLD.clan;
        END IF;
        IF OLD.hideranking = 0  THEN
          UPDATE hlstats_Clans SET members = members - 1 where clanId = OLD.clan;
        END IF;
      END IF;
      IF NEW.clan <> OLD.clan THEN
        IF NEW.clan <> 0  THEN
          UPDATE hlstats_Clans SET members = members + 1 where clanId = NEW.clan;
        END IF;
        IF OLD.clan <> 0 THEN
          UPDATE hlstats_Clans SET members = members - 1 where clanId = OLD.clan;
        END IF;
      END IF;
    END;
      SQL_ACTIONS
    end

    create_trigger("hlstats_players_after_insert_row_tr", :generated => true, :compatibility => 1).
        on("hlstats_Players").
        after(:insert) do
      <<-SQL_ACTIONS

    BEGIN
      IF NEW.clan <> 0 and NEW.hideranking = 0 THEN
        UPDATE hlstats_Clans SET members = members + 1 where clanId = NEW.clan;
      END IF;
    END;
      SQL_ACTIONS
    end

    create_trigger("hlstats_players_after_delete_row_tr", :generated => true, :compatibility => 1).
        on("hlstats_Players").
        after(:delete) do
      <<-SQL_ACTIONS

    BEGIN
      IF OLD.clan <> 0 and OLD.hideranking = 0 THEN
        UPDATE hlstats_Clans SET members = members - 1 where clanId = OLD.clan;
      END IF;
    END;
      SQL_ACTIONS
    end
  end

  def down
    drop_trigger("hlstats_players_after_update_of_clan_hideranking_row_tr", "hlstats_Players", :generated => true)

    drop_trigger("hlstats_players_after_insert_row_tr", "hlstats_Players", :generated => true)

    drop_trigger("hlstats_players_after_delete_row_tr", "hlstats_Players", :generated => true)
  end
end
