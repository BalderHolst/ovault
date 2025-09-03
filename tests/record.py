from test_examples import ROOT_DIR, SHELLS, EXPECTED_FILE, unwrap_shells, restore_vaults
import rere

if __name__ == "__main__":
    shells = unwrap_shells(SHELLS)
    # runs = [rere.capture(shell, cwd=ROOT_DIR) for shell in shells]
    runs = []
    for shell in shells:
        restore_vaults()
        result = rere.capture(shell, cwd=ROOT_DIR)
        runs.append(result)
    restore_vaults()
    rere.dump_snapshots(EXPECTED_FILE, runs)
