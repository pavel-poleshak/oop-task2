describe DbManager do
  let(:instance) { DbManager.new('test') }


  describe '#find_company' do
    let(:company) { instance.create_company(name: 'Company1') }

    subject { instance.find_company(company.id) }

    it { is_expected.to eq(company) }
  end

  describe '#find_employee' do
    let(:employee) { instance.create_employee('First Name', 'Last Name') }

    subject { instance.find_employee(employee.id) }

    it { is_expected.to eq(employee) }
  end

  describe '#edit_company' do
    let(:company) { instance.create_company(name: 'Company1') }

    before { instance.edit_company(company.id, 'New Name') }


    it { expect(instance.find_company(company.id).name).to eq('New Name') }
  end

  describe '#edit_employee' do
    let(:employee) { instance.create_employee('First Name', 'Last Name') }

    before { instance.edit_employee(employee.id, 'New Name') }

    it { expect(instance.find_employee(employee.id).first_name).to eq('New Name') }
  end
end